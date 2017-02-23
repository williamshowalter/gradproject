/*
 Language : english
*/
function ShowDDNSStatus(instr)
{
  msg = instr;
  msg = msg.replace("Disable","Disable")
  msg = msg.replace("Enable","Enable")
  msg = msg.replace("Success","Success")
  msg = msg.replace("Failure","Failure")
  msg = msg.replace("Updating.....","Updating.....")
  msg = msg.replace("No Change","No Change")
  msg = msg.replace("DDNS server reply error","DDNS server reply error")
  msg = msg.replace("Checking global IP Address","Checking global IP Address")
  document.write(msg);
}

function ShowMessageStatus(instr)
{
  var msg;
  if (instr == "No test conducted.")
    msg = "No test conducted.";
  else if  (instr == "Testing.....")
    msg = "Testing.....";
  else if  (instr == "Test succeeded.")
    msg = "Test succeeded.";
  else if  (instr == "Invalid FTP server address.")
    msg = "Invalid FTP server address.";
  else if  (instr == "Image not available.")
    msg = "Image not available.";
  else if  (instr == "Can not connect to FTP server.")
    msg = "Can not connect to FTP server.";
  else if  (instr == "Invalid username/password.")
    msg = "Invalid username/password.";
  else if  (instr == "TCP/IP socket error.")
    msg = "TCP/IP socket error.";
  else if  (instr == "Can not upload image file.")
    msg = "Can not upload image file.";
  else if  (instr == "Fail to change directory.")
    msg = "Failed to change directory.";
  else if  (instr == "Not support PASV mode.")
    msg = "Does not support PASV mode.";
  else if  (instr == "Not support PORT mode.")
    msg = "Does not support PORT mode.";
  else if  (instr == "Insufficient disk space.")
    msg = "Insufficient disk space.";	
  else if  (instr == "Can not create folder.")
    msg = "Can not create folder.";
  else if  (instr == "Failure.")
    msg = "Failure.";
  else if  (instr == "Invalid SMTP server address.")
    msg = "Invalid SMTP server address.";
  else if  (instr == "Can not connect to SMTP server.")
    msg = "Can not connect to SMTP server.";
  else if  (instr == "SMTP server reject.")
    msg = "SMTP server reject.";
  else if  (instr == "Can not send e-mail.")
    msg = "Can not send e-mail.";
  else if  (instr == "Disable")
    msg = "Disable";
  else if  (instr == "Enable")
    msg = "Enable";	
  else if  (instr == "Setting.....")
    msg = "Setting.....";
  else if  (instr == "Port open success")
    msg = "Port open success";
  else if  (instr == "Port already used by gateway")
    msg = "Port already used by gateway";
  else if  (instr == "Add port fail")
    msg = "Add port failed";
  else if  (instr == "Gateway upnp disable")
    msg = "Gateway upnp disable";
  else if  (instr == "Socket error")
    msg = "Socket error";
  else if  (instr == "Gateway wan port disconnected")
    msg = "Gateway WAN port disconnected";
  else if  (instr == "Unknown error")
    msg = "Unknown error";
  else if  (instr == "No")
    msg = "No";
  else if  (instr == "Yes")
    msg = "Yes";
  else if  (instr == "unknow")
    msg = "unknow";
  else if  (instr == "Half Duplex")
    msg = "Half Duplex";
  else if  (instr == "Full Duplex")
    msg = "Full Duplex";
  else if  (instr == "Infrastructure")
    msg = "Infrastructure";
  else if  (instr == "Adhoc")
    msg = "Adhoc";
  else if  (instr == "Invalid network folder.")
    msg = "Invalid network folder.";
  else if  (instr == "Can not connect to network folder.")
    msg = "Can not connect to network folder.";
  else if  (instr == "Can not write network folder.")
    msg = "Can not write network folder.";
  else if  (instr == "Insufficient disk space.")
    msg = "Insufficient disk space.";
  else
    msg = instr;
  document.write(msg);
}
