class Vim < Plugin
  requires_version '1.0.3'

  @oldmode = 'n'
  @mode = 'n'
  @maps = {}

  class << self; attr_accessor :mode, :maps, :oldmode; end

  def before
  end

  def growl(msg)
      system('/usr/local/bin/growlnotify -m "" -a Keymando ' + msg)
  end

  def tomode(m)
      oldmap = Vim.maps[Vim.mode]
      newmap = Vim.maps[m]

      except /iTerm/, /MacVim/, /Firefox/, /PeepOpen/, /Quicksilver/, /1Password/, /Alfred/ do
          oldmap.keys.each do |k|
              self.growl('Unmapping: ' + k)
              unmap(k)
          end

          newmap.keys.each do |k|
              map(k, newmap[k])
          end
      end

      Vim.mode = m
  end

  def toggle
      if Vim.mode == 'disabled'
          self.tomode(Vim.oldmode)
          self.growl('Keymando Vim mode enabled.')
      else
          Vim.oldmode = Vim.mode
          self.tomode('disabled')
          self.growl('Keymando Vim mode disabled.')
      end
  end

  def after
      Vim.maps['n'] = {
          'h' => lambda { send("<Left>") },
          'j' => lambda { send("<Down>") },
          'k' => lambda { send("<Up>") },
          'l' => lambda { send("<Right>") },

          'w' => lambda { send("<Alt-Right><Alt-Right><Alt-Left>") },
          'b' => lambda { send("<Alt-Left>") },
          'e' => lambda { send("<Alt-Right>") },
          '0' => lambda { send("<Cmd-Left>") },

          'gg' => lambda { send("<Cmd-Up>") },
          'G' => lambda { send("<Cmd-Down>") },

          'i' => lambda { self.tomode('i') },
          'a' => lambda { self.tomode('i'); send("<Right>") },
          'A' => lambda { self.tomode('i'); send("<Ctrl-e>") },
          'I' => lambda { self.tomode('i'); send("<Ctrl-a>") },
          'o' => lambda { self.tomode('i'); send("<Cmd-Right><Return>") },
          'O' => lambda { self.tomode('i'); send("<Cmd-Left><Return><Up>") },

          'd' => lambda { self.tomode('od') },
          'c' => lambda { self.tomode('oc') },

          'p' => lambda { send("<Cmd-Left><Down><Cmd-v>") },
          'P' => lambda { send("<Cmd-Left><Cmd-v>") },

          'u' => lambda { send("<Cmd-z>") },
          '<Ctrl-R>' => lambda { send("<Shift-Cmd-z>") },

          'x' => lambda { send("<Shift-Right><Cmd-x>") },
          's' => lambda { send("<Shift-Right><Cmd-x>"); self.tomode('i') },
      }
      Vim.maps['i'] = {
          '<Ctrl-[>' => lambda { self.tomode('n') },
          '<Escape>' => lambda { self.tomode('n') },
          'jk' => lambda { self.tomode('n') },
      }
      Vim.maps['od'] = {
          'w'  => lambda { send("<Shift-Alt-Right><Cmd-x>"); self.tomode('n') },
          'b'  => lambda { send("<Shift-Alt-Left><Cmd-x>"); self.tomode('n') },
          'd'  => lambda { send("<Cmd-Left><Shift-Down><Cmd-x>"); self.tomode('n') },

          'iw' => lambda { send("<Alt-Right><Shift-Alt-Left><Delete>"); self.tomode('n') },

          '<Escape>' => lambda { self.tomode('n') },
      }
      Vim.maps['oc'] = {
          'w' => lambda { send("<Shift-Alt-Right><Cmd-x>"); self.tomode('i') },
          'b'  => lambda { send("<Shift-Alt-Left><Cmd-x>"); self.tomode('i') },
          'c' => lambda { send("<Cmd-Left><Shift-Down><Cmd-x><Return><Up>"); self.tomode('i') },

          'iw' => lambda { send("<Alt-Right><Shift-Alt-Left><Delete>"); self.tomode('i') },

          '<Escape>' => lambda { self.tomode('n') },
      }
      Vim.maps['disabled'] = {}

      map "<Alt-Escape>", lambda { self.toggle }

      Vim.mode = 'disabled'
      self.tomode('n')
  end
end

