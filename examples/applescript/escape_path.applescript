#!/usr/bin/osascript

global escaped_path

on run
  set p to "/Users/jeff/Applications/Invisor Lite.app"
  set escaped_path to quoted form of POSIX path of p

  display dialog "p=" & p & "\nescaped_path=" & escaped_path & "\n"

  -- set escaped_path to "quoted form of POSIX path of (POSIX file \"./\" as alias)"
  -- print escaped_path

  return escaped_path
end run
