
--Start of Global Scope---------------------------------------------------------

-- Create a ftp server instance
local ftpServer = FTPServer.create()
-- Set the server port to 12345
FTPServer.setServerPort(ftpServer, 12345)
-- Create a user account with home directory pointing to ram filesystem
FTPServer.addUser(ftpServer, 'user', 'password', 'private')
-- Start the ftp server
FTPServer.start(ftpServer)

-- Create a ftp client instance
local handle = FTPClient.create()
-- Set server ip address and port
FTPClient.setIpAddress(handle, '127.0.0.1')
FTPClient.setPort(handle, 12345)

-- Try to connect to the server
if (FTPClient.connect(handle, 'user', 'password')) then
  -- Set transfer mode to ascii
  if (FTPClient.setMode(handle, 'ASCII')) then
    -- Remove test directory (might have been created in a preceding run)
    FTPClient.rmdir(handle, 'test')
    -- Create test directory
    FTPClient.mkdir(handle, 'test')
    -- Change to test directory
    if (FTPClient.cd(handle, 'test')) then
      -- Put a file with dummy contents
      if (FTPClient.put(handle, 'file.txt', 'dummy file contents')) then
        print('File successfully written to FTP server')
      else
        print('Failed to write file')
      end
    else
      print('Failed to change directory')
    end
  else
    print('Failed to set mode')
  end
else
  print('Failed to connect to FTP server')
end

-- Disconnect the client
FTPClient.disconnect(handle)
-- Stop the ftp server
FTPServer.stop(ftpServer)

print('App finished.')

--End of Global Scope-----------------------------------------------------------
