# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import *

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

# You can import any python module as needed.
import os
import shlex

# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!


class ipython(Command):
    """ drop into ipython shell, you have fm  in the namespace"""

    def execute(self):
        from traitlets.config.loader import Config
        from IPython.terminal.embed import InteractiveShellEmbed
        from IPython.lib.guisupport import start_event_loop_qt4
        cfg = Config()
        cfg.TerminalInteractiveShell.banner1 = 'Dropping into IPython'
        cfg.TerminalInteractiveShell.banner2 = '"fm" is your access to the ranger fm\n'
        cfg.PromptManager.in_template="ranger [\\#]> "
        cfg.PromptManager.out_template="ranger [\\#]: "
        cfg.PromptManager.autoindent = False
        shell = InteractiveShellEmbed(
            config=cfg,
            user_ns={'fm':self.fm},
            exit_msg='Leaving Interpreter, back to program.',
        )
        self.fm.ui.suspend()
        shell('started')
        self.fm.ui.initialize()
class rfind(Command):
    """
    :rfind <string>

    uses the normal find command to find stuff on current path, you can use all
    normal find options
    """

    def execute(self):
        if self.rest(1):
            action = ['find']
            action.extend(f.path for f in self.fm.thistab.get_selection())
            find_options = shlex.split(self.rest(1))
            if len(find_options) == 1: # then i ment of course find this pattern
                action.append('-name')
            action.extend(find_options)
            self.fm.execute_command(action, flags='p')
class ack(Command):
    """
    :ack <string>

    Looks for a string in all marked files or directories
    """
    def execute(self):
        if self.rest(1):
            args =shlex.split(self.rest(1))
            action = ['ack', '--pager=less -R'] + args
            action.extend(f.path for f in self.fm.thistab.get_selection())
            self.fm.execute_command(action, flags='')

class gvimserver(Command):
    """
    :gvimserver <name>
    Opens the selected files in the specified gvim server buffers
    """
    def tab(self):
        # get serverlist
        a = (self.firstpart + i for i in
                os.popen('gvim --serverlist').read().split('\n'))
        return a

    def execute(self):
        from ranger.ext.get_executables import get_executables
        # get selected files
        filenames = [f.basename for f in self.fm.env.get_selection()]
        # get terminal command
        cmd = os.environ.get('TERMCMD', os.environ.get('TERM'))
        if cmd not in get_executables():
            cmd = 'x-terminal-emulator'
        if cmd not in get_executables():
            cmd = 'xterm'
        # assembly command
        command = (cmd + ' -e vim --servername ' + self.rest(1) +
                ' --remote-silent ' + ' '.join(filenames))
        self.fm.run(command, flags='f')

class zip_dir(Command):
    """"
    :zip <name>
    Creates a zip of selected files with given name

    from: http://stackoverflow.com/a/296722/1607448
    """

    def zipdir(self,basedirs, archivename):
        from contextlib import closing
        from zipfile import ZipFile, ZIP_DEFLATED
        import os
        with closing(ZipFile(archivename, "w", ZIP_DEFLATED)) as z:
            for basedir in basedirs:
                assert os.path.isdir(basedir)
                for root, dirs, files in os.walk(basedir):
                    #NOTE: ignore empty directories
                    for fn in files:
                        absfn = os.path.join(root, fn)
                        z.write(absfn, absfn)

    def execute(self):
        if self.rest(1):
            all_args = shlex.split(self.rest(1))
            # get selected files
            dirs = [f.basename for f in self.fm.thistab.get_selection()]
            # construct action
            outputname = all_args[-1]
            args = all_args[:-1]
            #action = ['zip'] + args + files + [outputname]
            #self.fm.notify(action,bad=True)
            #self.fm.execute_command(action, flags='')
            self.zipdir(dirs, outputname + '.zip')
        else:
            self.fm.notify('provide a output name',bad=True)

class mount_zip(Command):
    """"
    :zip <name>
    Creates a zip of selected files with given name
    """
    def execute(self):
        # construct action
        action = ['fuse-zip']
        # get selected files
        files = [f.basename for f in self.fm.thistab.get_selection()]
        ## if zip extension
        if self.rest(1) and len(files)==1:
            directories = [self.rest(1)]
        else:
            directorys = [os.path.splitext(f)[0] for f in files]
        # mount the shit
        for f,d in zip(files,directorys):
            if f != d:
                try:
                    os.mkdir(d)
                    action.extend((f,d))
                    self.fm.execute_command(action, flags='')
                except OSError as e:
                    if e.errno == os.errno.EEXIST:
                        self.fm.notify('directory exists already, specify an'
                                    ' alternative mountpoint',bad=True)

class fuseumount(Command):
    def execute(self):
        files = [f.basename for f in self.fm.thistab.get_selection()]
        for f in files:
            try:
                self.fm.execute_command(['fusermount','-u',f], flags='')
                os.rmdir(f)
            except Exception as e:
                self.fm.notify(e,bad=True)

class pdfinfo(Command):
    def execute(self):
        files = [f.basename for f in self.fm.thistab.get_selection()]
        pn = []
        for f in files:
            pn.append((f,os.popen(
                'pdfinfo {0} | grep "^Pages: *[0-9]\+$" | sed "s/.* //"'
                .format(f)).read().strip()))
        self.fm.notify(pn)

class echo_selection_to(Command):
    def execute(self):
        with open(self.rest(1),'w') as f:
            for x in self.fm.thistab.get_selection():
                f.write(x.basename)
                f.write('\n')

class deadbeef(Command):
    def execute(self):
        with open('/dev/null','w') as null:
            for selection in self.fm.thistab.get_selection():
                subprocess.Popen(['deadbeef','--queue', selection.path],stdout=null,stderr=null)

class log(Command):
    """
    :log

    Displays the log of the current repo or files
    """
    def execute(self):
        from ranger.ext.vcs import VcsError
        import tempfile

        L = self.fm.thistab.get_selection()
        if len(L) == 0: return

        filelist = [f.path for f in L]
        vcs = L[0].vcs

        log = vcs.get_raw_log(filelist=filelist)
        tmp = tempfile.NamedTemporaryFile()
        tmp.write(log.encode('utf-8'))
        tmp.flush()

        pager = os.environ.get('PAGER', ranger.DEFAULT_PAGER)
        self.fm.run([pager, tmp.name])

class diff(Command):
    """
    :diff

    Displays a diff of selected files against last last commited version
    """
    def execute(self):
        from ranger.ext.vcs import VcsError
        import tempfile

        L = self.fm.thistab.get_selection()
        if len(L) == 0: return

        filelist = [f.path for f in L]
        vcs = L[0].vcs

        diff = vcs.get_raw_diff(filelist=filelist)
        if len(diff.strip()) > 0:
            tmp = tempfile.NamedTemporaryFile()
            tmp.write(diff.encode('utf-8'))
            tmp.flush()

            pager = os.environ.get('PAGER', ranger.DEFAULT_PAGER)
            self.fm.run([pager, tmp.name])
        else:
            raise Exception("diff is empty")
