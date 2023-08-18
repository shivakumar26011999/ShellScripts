#! /bin/bash
declare -a users

function addUser() {
  read -p "Enter username : " uname
  if [[ ${users[@]} =~ ${uname} ]]; then
    echo "WARN :: User already exists. Please enter unique username."
    init
  fi

  len=${#users[@]}
  users[${len}]=${uname}
  echo "INFO :: User registered."
}

function getUser() {
  read -p "Enter username : " name
  if [[ ${users[@]} =~ ${name} ]]; then
    echo "INFO :: User exists."
  fi
}

function deleteUser() {
  read -p "Enter username : " name
  for i in ${!users[@]}
  do
    if [ ${users[${i}]} = ${name} ]; then
      unset users[${i}]
      echo "INFO :: User unregistered."
      init 
    fi
  done
}

function allUsers() {
  echo "Here are registered users : ${users[@]}"
}

function init() {
  while [ true ]
  do
    echo "------------------------"
    echo "ADD USER   -  1"
    echo "GET USER   -  2"
    echo "DEL USER   -  3"
    echo "ALL USERS  -  4"
    echo "EXIT APP   -  5"

    read -p "Enter provided option : " option

    case ${option} in
      1) addUser
         ;;
      2) getUser
         ;;
      3) deleteUser
         ;;
      4) allUsers
         ;;
      5) echo "Program terminated."
         exit 1
         ;;
      *) echo "Please select option displayed."
         esac
  done
}

init