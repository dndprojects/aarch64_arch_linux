local json = require('cjson')


function on_msg_receive (msg)
  
  if msg.out then
   return
  end
  if (msg.from.print_name=='phone1' or msg.from.print_name=='phone2') then
      find_cmd = sqlite_cmd(msg.text)
      
      if (find_cmd[2]=='http') then
         run_http(find_cmd[3])
         send_msg (msg.from.print_name, find_cmd[4] , ok_cb, false)
      end
	  
	  if (find_cmd[2]=='os') then
         run_os(find_cmd[3],find_cmd[5])
		 if (find_cmd[5]== "nil" ) then find_cmd[5] = "" end
         send_msg (msg.from.print_name, find_cmd[4] .. " " .. find_cmd[5] , ok_cb, false)
      end
	  	    
	  if (find_cmd[2]=='aos') then
         run_aos(find_cmd[3])
		 if (find_cmd[5]== "nil" ) then find_cmd[5] = "" end
         send_msg (msg.from.print_name, find_cmd[4] .. " " .. find_cmd[5] , ok_cb, false)
      end
	  
	  if (find_cmd[2]=='timer') then
         run_timer(find_cmd[3],find_cmd[5])
	     if (find_cmd[5]== "nil" ) then find_cmd[5] = "" end
         send_msg (msg.from.print_name, find_cmd[4].. " " .. find_cmd[5]  , ok_cb, false)
      end
	  
	  if (find_cmd[2]=='json') then
	     local json_out = run_jason(find_cmd[3])
        send_msg (msg.from.print_name, find_cmd[4].."\n" .. json_out[4] , ok_cb, false)
		-- send_msg (msg.from.print_name, find_cmd[4] , ok_cb, false)

      end
	  
	  if (find_cmd[2]=='nil') then
         send_msg (msg.from.print_name, find_cmd[4] , ok_cb, false)
      end
	  
	  
   else 
    send_msg (msg.from.print_name, ' אין אישור ' .. msg.from.print_name , ok_cb, false)
   end
  
end
   
  function on_our_id (id)
  end
   
  function on_secret_chat_created (peer)
  end
   
  function on_user_update (user)
  end
   
  function on_chat_update (user)
  end
   
  function on_get_difference_end ()
  end
   
  function on_binlog_replay_end ()
  end

function rows (connection, sql_statement)
  cur = assert (connection:execute (sql_statement))
  return function ()
     return cur:fetch()
   end
end

function sqlite_cmd (remote_cmd)

   local remote_string = {"nil","nil","nil"}
   local sh_commands = {"nil","nil","nil","nil","nil","nil"}
   local n = 1
   local all_commands = ""
   local driver = require('luasql.sqlite3')
   local env = driver.sqlite3()
   local remote_cmd_striped = ""
   
   for i in string.gmatch(remote_cmd, "%S+") do
	 table.insert(remote_string,n,i)
	 print(remote_string[n])
	 n = n + 1
   end
   print (remote_cmd)
   if (remote_string[2]=="nil") then 
      remote_cmd_striped = remote_string[1]
	 else
	  remote_cmd_striped = remote_string[1] .. " " .. remote_string[2]
   end

   con = assert (env:connect'/srv/http/sqlite/whatsapp_cmd.db')
   for  message_cmd, cmd_type, cmd, response in rows (con, "select * from commands") do
      all_commands = all_commands .. "\n" .. message_cmd
	   table.insert(sh_commands,3,cmd)
	   table.insert(sh_commands,4,all_commands)
	  if (remote_cmd==message_cmd) then
	   --print (string.format ("%s: %s", message_cmd, cmd_type))
	   table.insert(sh_commands,1,message_cmd)
	   table.insert(sh_commands,2,cmd_type)
	   table.insert(sh_commands,3,cmd)
	   table.insert(sh_commands,4,response)
	   break
      end
	  if (remote_cmd_striped==message_cmd) then
	   --print (string.format ("%s: %s", message_cmd, cmd_type))
	   table.insert(sh_commands,1,message_cmd)
	   table.insert(sh_commands,2,cmd_type)
	   table.insert(sh_commands,3,cmd)
	   table.insert(sh_commands,4,response)
	   break
      end
   end
   cur:close()
   con:close()
   env:close()
   table.insert(sh_commands,5,remote_string[3])
   return sh_commands
end

function run_http (url)
  --timer_cmd = 'http://127.0.0.1:8080/json.htm?type=command&param=updateuservariable&vname='+timer_var+'&vtype=integer&vvalue='+delay
  local cmd = "curl -s  '" .. url .. "'"
  print ("running http -->" .. cmd)
  os.execute(cmd)
end

function run_timer (url,run_time)
  if (opt=="nil") then 
    opt =""
  end
  local run_cmd = {"nil","nil","nil"}
  local n = 1
   for i in string.gmatch(url, "%S+") do
	 table.insert(run_cmd,n,i)
     n = n + 1
   end
  local cmd = "curl -s  '" .. run_cmd[2] .. run_time .. "'\n"
  print (cmd) 
  os.execute(cmd)
  local cmd = "curl -s  '" .. run_cmd[1] .. "'\n"
  print (cmd)
  os.execute(cmd)  
end

function run_os (sh_cmd,opt)
  if (opt=="nil") then 
    opt =""
  end
  local run_cmd = {"nil","nil"}
  local n = 1
   for i in string.gmatch(sh_cmd, "%S+") do
	 table.insert(run_cmd,n,i)
         if (n < 2 ) then n = n + 1  end
   end
   local cmd_argv = sh_cmd:gsub(run_cmd[1], "")
   table.insert(run_cmd,2,cmd_argv) 
   print (run_cmd[1] .. ' ' .. run_cmd[2] ..  ' ' .. opt)
   os.execute('"' .. run_cmd[1] .. '" ' .. run_cmd[2] .. ' ' .. opt )
end

function run_aos (sh_cmd)
  local run_cmd = sh_cmd
  os.execute(run_cmd)
end

function run_jason (url) 
 print "1 jason"
 local cmd = "curl -s  '".. url .. "'"
 local return_string = {"nil","nil","nil","nil","nil"}
 local handle = io.popen(cmd)
 local replay = handle:read("*a")
 handle:close()
 rPrint(json.decode(replay),1000,1000)
 table.insert(return_string,4,json.decode(replay))
 return return_string
end


function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function run_jason (url,shabbat_shalom) 
 print "2 jason"
 local cmd = "curl -s  '".. url .. "'"
 local mystatus = ""
 local return_string = {"nil","nil","nil","nil","nil"}
 local handle = io.popen(cmd)
 local replay = handle:read("*a")
 handle:close()
 local tab = json.decode(replay)
 print(printmyt(tab))

 if (isempty(tab["Sunrise"])) then
    else
	local_time_s = split(tab["Sunset"],":")
    local now=os.time({year=2000,month=4,day=6,hour=local_time_s[1], min=local_time_s[2]})
	sabbat_start=os.date("%H:%M",now-1200 )
    sabbat_end=os.date("%H:%M",now+2100 )
	mystatus = "כניסת שבת: " .. sabbat_start .. "\n" .. "צאת השבת: " .. sabbat_end
	table.insert(return_string,4,mystatus)
  end
  
  if (isempty(tab["hebrew"])) then
    else
	mystatus = tab["hebrew"] ..  "\n" .. tab["events"][1] ..  "\n" .. tab["events"][2]
	table.insert(return_string,4,mystatus)
  end
  
 if (tab["result"] == nil) then 
   return return_string 
 end
 
 local lenth = (tablelength(tab["result"]))
  for i=1,lenth  do 
   if (isempty(tab["result"][i]["Data"])) then
    else
    local tmpmystatus = (tab["result"][i]["Name"] ..  " " .. tab["result"][i]["Data"])
	mystatus = mystatus .. "\n" .. tmpmystatus
   end
   if (isempty(tab["result"][i]["Value"])) then
    else
    local tmpmystatus = (tab["result"][i]["Name"] ..  " => " .. tab["result"][i]["Value"])
	mystatus = mystatus .. "\n" .. tmpmystatus
   end
  end
   table.insert(return_string,4,mystatus)
   return return_string
end

function isempty(s)
  return s == nil or s == ''
end

function printmyt(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. printmyt(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


function split(str, sep)
   local result = {}
   local regex = ("([^%s]+)"):format(sep)
   for each in str:gmatch(regex) do
      table.insert(result, each)
   end
   return result
end
