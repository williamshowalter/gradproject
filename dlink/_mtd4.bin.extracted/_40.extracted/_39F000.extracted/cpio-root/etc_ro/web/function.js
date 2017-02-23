function CheckBrower()
{
  ba = navigator.userAgent;
  bn = navigator.appName;
  bv = navigator.appVersion;
  bv2 = bv.substring(0,3);
  if (ba.indexOf("Opera",0) != -1)
  {
     if (bv2 <= "9.0")
        return("Opera<9");
     else
        return("Opera");
  }
  if (ba.indexOf("Firefox",0) != -1)
     return("Firefox");
  if (ba.indexOf("Chrome",0) != -1)
     return("Chrome");
  if (ba.indexOf("Safari",0) != -1)
     return("Safari");
  if (ba.indexOf("KKMAN",0) != -1)
     return("KKMAN");
  if (bn.indexOf("Microsoft Internet Explorer",0) != -1)
  {
     bc1 = ba.indexOf("MSIE ",0);
     bc2 = ba.substring(bc1+5);
     bc3 = bc2.indexOf(";",0);
     bc4 = bc2.substring(0,bc3);
     bc5 = parseInt(bc4,10);
     if (bc5 < 10) {
        if ((bv.indexOf("Trident/6",0) != -1) && (bv.indexOf("Windows NT 6",0) != -1))
            return("IE10");
        else
            return("IE");
     } else
        return("IE10");
  } else {
     if ((bv.indexOf("Trident/7",0) != -1) && (bv.indexOf("Windows NT 6",0) != -1))
        return("IE10");
  }
  if (bn.indexOf("Netscape",0) != -1)	
     return("Netscape");
   return("Unknow");
}
/*
 show time :time colock 
*/
function showtime(index)
{
    var now = new Date();
    while (__sec >= 60)
    {
    	__sec = __sec - 60;
    	__min++;
    }
    while (__min >= 60)
    {
    	__min = __min - 60;
    	__hour++;
    }
    while (__min < 0)
    {
    	__min = __min + 60;
    	__hour--;
    }
    while (__hour >= 24)
    {
    	__hour = __hour - 24;
    	__date++;
    }
    while (__hour < 0)
    {
    	__hour = __hour + 24;
    	__date--;
    }
    now.setYear(__year);
    now.setMonth(__month-1);
    now.setDate(__date);
    now.setHours(__hour);
    now.setMinutes(__min);
    now.setSeconds(__sec);
    var year = now.getFullYear();
    var month = now.getMonth()+1;
    var date = now.getDate();
    var hours = parseInt(__hour,10);
    var minutes = parseInt(__min,10);
    var seconds = parseInt(__sec,10);

    var month_1 = new Array();
    month_1[0] = "Jan";
    month_1[1] = "Feb";
    month_1[2] = "Mar";
    month_1[3] = "Apr";
    month_1[4] = "May";
    month_1[5] = "Jun";
    month_1[6] = "Jul";
    month_1[7] = "Aug";
    month_1[8] = "Sep";
    month_1[9] = "Oct";
    month_1[10] = "Nov";
    month_1[11] = "Dec";
    
    var timeValue = "";
    timeValue += ((date < 10) ? "0" : "") + date ;
    
    timeValue += ((month < 10) ? " " : " ") + month_1[month-1] ;
    timeValue += " "+year;
    
    timeValue += " ";
    if (hours == 0)
    	timeValue  += (12)
    else
    	timeValue  += ((hours > 12) ? hours - 12 : hours)
    timeValue  += ((minutes < 10) ? ":0" : ":") + minutes
    timeValue  += ((seconds < 10) ? ":0" : ":") + seconds
    timeValue  += (hours >= 12) ? " P.M." : " A.M."
    
    document.getElementById('timeclock').innerHTML = timeValue;
    __sec++;
    timerID = setTimeout("showtime("+index+")",1000);
}
function GetPCTime(i)
{
    var now = new Date();      
    document.forms[i].s_year.value = now.getFullYear(); 
    document.forms[i].s_month.value = now.getMonth()+1;
    document.forms[i].s_date.value = now.getDate();
    document.forms[i].s_hour.value = now.getHours();
    document.forms[i].s_min.value = now.getMinutes();
    document.forms[i].s_sec.value = now.getSeconds();
}
function disable(eid)
{
    if (document.getElementById(eid) == null) return;
       document.getElementById(eid).disabled=true;
}
function enable(eid)
{
    if (document.getElementById(eid) == null) return;
    document.getElementById(eid).disabled=false;
}
function disable_box(eid)
{
    for (i=0;i<eid.getElementsByTagName("input").length;i++)
    {
        eid.getElementsByTagName("input")[i].disabled = true;        
    }
    for (i=0;i<eid.getElementsByTagName("select").length;i++)
    {
        eid.getElementsByTagName("select")[i].disabled = true;        
    }
}
function enable_box(eid)
{
    for (i=0;i<eid.getElementsByTagName("input").length;i++)
    {
        eid.getElementsByTagName("input")[i].disabled = false;        
    }
    for (i=0;i<eid.getElementsByTagName("select").length;i++)
    {
        eid.getElementsByTagName("select")[i].disabled = false;          
    }
    
}
function show(eid) 
{
    if (document.getElementById(eid) == null) return;
       document.getElementById(eid).style.display = '';  
}
function hide(eid) 
{
    if (document.getElementById(eid) == null) return;
       document.getElementById(eid).style.display = 'none';
}
function date_check(time_str)
{
    var mt = time_str.match(/^(\d{1,4})\-(\d{1,2})\-(\d{1,2})$/);
    if (!mt || mt[1] < 0 && mt[2] < 0 && mt[3] < 0)
       return 1;
    if (!mt || mt[1] < 2010 || mt[2] > 12 || mt[3] > 31)
       return 1;
    else {
       var ndate;
       var end_day;
       var year = mt[1];
       var month = mt[2];
       var day = mt[3];
       
       if (month == 2)
       { 
          if ((year % 400) == 0)
             end_day = 29;
          else
          {
             if ((year % 100) == 0)
                end_day = 28;
             else
             {
                if ((year % 4) == 0)
                   end_day = 29;
                else
                   end_day = 28;
             }
          }
          
       }
       else 
       {
          if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
             end_day = 31;
          else
             end_day = 30;
       }
       if (day > end_day)
          return 1;
       ndate = parseInt(mt[1],10);
       if (mt[2] >= 10)
          ndate = ndate+"-"+parseInt(mt[2],10);
       else
          ndate = ndate+"-0"+parseInt(mt[2],10);
       if (mt[3] >= 10)
          ndate = ndate+"-"+parseInt(mt[3],10);
       else
          ndate = ndate+"-0"+parseInt(mt[3],10);
       return ndate;
    }
}
function time_check(time_str)
{
    var mt = time_str.match(/^(\d{1,2})\:(\d{1,2})\:(\d{1,2})$/);
    if (!mt || mt[1] < 0 && mt[2] < 0 && mt[3] < 0)
       return 1;
    if (!mt || mt[1] > 23 || mt[2] > 59 || mt[3] > 59)
       return 1;
    else {
       var ntime;
       if (mt[1] >= 10)
          ntime = parseInt(mt[1],10);
       else
          ntime = "0"+parseInt(mt[1],10);
       if (mt[2] >= 10)
          ntime = ntime+":"+parseInt(mt[2],10);
       else
          ntime = ntime+":0"+parseInt(mt[2],10);
       if (mt[3] >= 10)
          ntime = ntime+":"+parseInt(mt[3],10);
       else
          ntime = ntime+":0"+parseInt(mt[3],10);
       return ntime;
    }
}

function daynight_check(time_str)
{
    var mt = time_str.match(/^(\d{1,2})\:(\d{1,2})$/);
    if (!mt || mt[1] < 0 && mt[2] < 0)
       return 1;
    if (!mt || mt[1] > 24 || mt[2] > 59)
       return 1;
    if (!mt || (mt[1] == 24 && mt[2] > 0))
       return 1;
    else {
       var ntime;
       if (mt[1] >= 10)
          ntime = parseInt(mt[1],10);
       else
          ntime = "0"+parseInt(mt[1],10);
       if (mt[2] >= 10)
          ntime = ntime+":"+parseInt(mt[2],10);
       else
          ntime = ntime+":0"+parseInt(mt[2],10);
       return ntime;
    }
}

function period_check(time_start,time_end)
{
	var mt, min_start, min_end;
	
    mt = time_start.match(/^(\d{1,2})\:(\d{1,2})$/);
    min_start = parseInt(mt[1],10) * 60 + parseInt(mt[2],10);
    mt = time_end.match(/^(\d{1,2})\:(\d{1,2})$/);
    min_end = parseInt(mt[1],10) * 60 + parseInt(mt[2],10);
    
    if (min_start > min_end)
       return 1;
    else
       return 0;
}

function daynightperiod_check(sid,eid)
{
  startid = document.getElementById(sid);
  endid = document.getElementById(eid);
  if (daynight_check(startid.value) == 1)
     return 1;
  if (daynight_check(endid.value) == 1)
     return 2;
  startid.value = daynight_check(startid.value);
  endid.value = daynight_check(endid.value);
  if (period_check(startid.value,endid.value) == 1)
     return 3;
  return 0;
}

function devip_check(ip_str)
{
    var mt = ip_str.match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/);
    if (!mt || mt[1] >= 255 && mt[2] >= 255 && mt[3] >= 255 && mt[4] >= 255)
       return 1;
    if (!mt || mt[1] <= 0 && mt[2] <= 0 && mt[3] <= 0 && mt[4] <= 0)
       return 1;
    if (!mt || mt[1] == 255 && mt[2] == 255 && mt[3] == 255 && mt[4] == 255)
       return 1;
    if (!mt || mt[1] == 255 && mt[2] == 255 && mt[3] == 255 && mt[4] == 0)
       return 1;
    if (!mt || mt[1] == 255 && mt[2] == 255 && mt[3] == 0 && mt[4] == 0)
       return 1;
    if (!mt || mt[1] == 255 && mt[2] == 0 && mt[3] == 0 && mt[4] == 0)
       return 1;
    if (!mt || mt[1] < 1 || mt[1] > 223 || mt[1] == 0 || mt[1] == 127)
       return 1;
    if (!mt || mt[1] > 255 || mt[2] > 255 || mt[3] > 255 || mt[4] > 255)
       return 1;
    else
       return parseInt(mt[1],10)+ "."+parseInt(mt[2],10)+"."+parseInt(mt[3],10)+"."+parseInt(mt[4],10);
}
function ip_check(ip_str)
{
    var mt = ip_str.match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/);
    if (!mt || mt[1] >= 255 && mt[2] >= 255 && mt[3] >= 255 && mt[4] >= 255)
       return 1;
    if (!mt || mt[1] <= 0 && mt[2] <= 0 && mt[3] <= 0 && mt[4] <= 0)
       return 1;
    if (!mt || mt[1] > 255 || mt[2] > 255 || mt[3] > 255 || mt[4] > 255)
       return 1;
    else
       return parseInt(mt[1],10)+ "."+parseInt(mt[2],10)+"."+parseInt(mt[3],10)+"."+parseInt(mt[4],10);
}
function ip_same_net(ip,netmask,gateway)
{
    var mt1 = ip.match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/);
    var mt2 = netmask.match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/);
    var mt3 = gateway.match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/);
    
    if (((mt1[1]&mt2[1]) == (mt2[1]&mt3[1])) && ((mt1[2]&mt2[2]) == (mt2[2]&mt3[2])) && ((mt1[3]&mt2[3]) == (mt2[3]&mt3[3])) && ((mt1[4]&mt2[4]) == (mt2[4]&mt3[4])))
       return 0;
    else
       return 1;
}

function check_mask(ip,netmask)
{
    var mt1 = ip.match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/);
    var mt2 = netmask.match(/^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/);
    var chk1=255-mt2[1],chk2=255-mt2[2],chk3=255-mt2[3],chk4=255-mt2[4];
    
    if (((mt1[1]&chk1) == 0) && ((mt1[2]&chk2) == 0) && ((mt1[3]&chk3) == 0) && ((mt1[4]&chk4) == 0))
       return 1;
    if (((mt1[1]&chk1) == chk1) && ((mt1[2]&chk2) == chk2) && ((mt1[3]&chk3) == chk3) && ((mt1[4]&chk4) == chk4))
       return 1;
    return 0;
}
function checkIntRange(i,max,min)
{
    var mt = i.match(/[^0-9]/);
    if (mt)
       return 1;
    if ((isNaN(i)) || (i>max) || (i<min))
       return 1;
    if (parseInt(i) != i)
       return 1;
    return 0;
}
function checkHttpPort(i)
{
	/* FTP SRV(20,21), Telnet(23), Production Testing(8481) */
	if ((i == 20) || (i == 21) || (i == 23) || (i == 8481))
       return 1;
    return 0;
}
function CheckHex(str)
{
    var mt = str.match(/[^a-fA-F0-9]/);
    if (mt)
       return 1;
    else 
       return 0;
}
function CheckBonjourname(str)
{
    var mt = str.match(/[^a-zA-Z0-9-]/);
    if ((str == "") || (mt))
	   return 1;
    else
	   return 0;
}
function CheckSrvname(str)
{
    if (str == "")
       return 1;
    else
    {
       for (i=0;i<str.length;i++)
       {
           j = str.charCodeAt(i);
           if ((j < 33) || (j == 34) || (j == 38) || (j == 39) || (j == 60) || (j == 62) || (j > 126))
              return 1;
       }
       return 0;
	}
}
function CheckUsername(str)
{
    var mt = str.match(/[^a-zA-Z0-9._-]/);
    if ((str == "") || (mt))
       return 1;
    else 
       return 0;
}
function CheckUserpass(str)
{
    for (i=0;i<str.length;i++)
    {
        j = str.charCodeAt(i);
        if ((j < 33) || (j == 47) || (j == 58) || (j > 126))
           return 1;
    }
    return 0;
}
function CheckWPAKey(Key)
{
    if ((Key.length < 8) || (Key.length > 64))
       return 1;
    if (Key.length == 64)
    {
       if (CheckHex(Key) == 1)
          return 1;
       else
          return 0;
    }
    return 0;
}
function filename_check(str)
{
    var mt = str.match(/[^a-zA-Z0-9_-]/);
    if (mt)
       return 1;
    else
       return 0;
}
function basefilename_check(str)
{
    var mt = str.match(/[^a-zA-Z0-9_-]/);
    if (str.length <= 0)
       return 1;
    if (mt)
       return 1;
    else
       return 0;
}
function getHEXString(instr)
{
   var hex_tab = "0123456789ABCDEF";
   var outstr = "";
   var i,j;

   for (i=0;i<instr.length;i++)
   {
       j = instr.charCodeAt(i);
       k = (j&0xf0)>> 4;
       outstr += hex_tab.charAt(k);
       l = (j&0x0f);
       outstr += hex_tab.charAt(l);
   }
   return outstr;
}
function getStringFromHex(instr)
{
   var outstr = "";
   var i,j;

   for (i=0;i<instr.length;i++)
   {
       j = instr.charCodeAt(i);
       if ((j>=48) && (j<=57))
          j = j - 48;
       else
          j = j - 55;
       i++
       k = instr.charCodeAt(i);
       if ((k>=48) && (k<=57))
          k = k - 48;
       else
          k = k - 55;
       outstr += String.fromCharCode(j*16+k);
   }
   return outstr;
}
function getHTMLString(instr)
{
   var outstr = "";
   var i,j;

   for (i=0;i<instr.length;i++)
   {
       j = instr.charAt(i);
       if (j == ' ')
       	  outstr += "&nbsp;";
       else if (j == '"')
       	  outstr += "&quot;";
       else if (j == '&')
       	  outstr += "&amp;";
       else if (j == '<')
       	  outstr += "&lt;";
       else if (j == '>')
       	  outstr += "&gt;";
       else
       	  outstr += j;
   }
   return outstr;
}
function clickScheduleEnable(vid,cid)
{
  valueid = document.getElementById(vid);
  checkid = document.getElementById(cid);
  if (checkid.checked)
     valueid.value = 1;
  else
     valueid.value = 0;
}
function clickScheduleDay(vid,cid,bit)
{
  valueid = document.getElementById(vid);
  checkid = document.getElementById(cid);
  check = 0x01 << (bit);
  value = parseInt(valueid.value,10);
  if (checkid.checked)
     value |= check;
  else
     value ^= (check);
  valueid.value = value.toString();
}
function CheckShortfilename(str)
{
     if ((str.length > 12) || (str.length <= 0))
	return 1;
    x = y = z = 0;
    for (i=0;i<str.length;i++)
    {
        j = str.charCodeAt(i);
        if (j == 46)
        {
           z++;
           continue;
        }
        if (z == 0)
           x++;
        else
           y++;
    }
    if ((x <= 0) || (x > 8) || (y >3) || (z > 1))
	return 1;
    return 0;
}
