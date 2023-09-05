############################################################################
#                           Scripted By : Shiva                            #
#                           Scripted On : 03/09/2023                       #
############################################################################

#! /bin/bash
declare -a books

function addBook() {
  echo "INFO :: Registering book."
  read -p "Enter the book name: " book
  if [[ ${books[@]} =~ ${book} ]]; then
    echo "WARN :: Book already exists."
    init
  fi

  len=${#books[@]}
  books[${len}]=${book}
  
  # below expression also works to add book to an array.
  # books+=("${book}") 
  echo "INFO :: Book registered."
}

function listBooks() {
  echo "INFO :: Listing books present."

  if [ ${#books[@]} -gt 0 ]; then
    for book in ${books[@]}
    do
      echo ${book}
    done
    echo "INFO :: Listing complete."
  else 
    echo "WARN :: No book exist."
  fi
  
  # below code also works for listing items.
  # for((i=0; i<${#books[@]}; i++));
  # do
  #   echo ${books[${i}]}
  # done
}

function unRegisterBook() {
  echo "INFO :: Unregistering book."

  if [ ${#books[@]} -le 0 ]; then
    echo "WARN :: No book exists."
    init
  fi

  read -p "Enter book name to unregister: " book
  if [[ ${books[@]} =~ ${book} ]]; 
  then
    for((i=0; i<${#books[@]}; i++));
    do
      if [ ${books[${i}]} = ${book} ]; then
        unset books[${i}]
        echo "INFO :: Book ${book} unregistered."
      fi
    done
  else
    echo "WARN :: Book ${book} doesn't exists."
  fi
}

function init() {
  while [ true ]
do
  echo "-----------------------------"
  echo "To register book   : Select A"
  echo "To list books      : Select B"
  echo "To unregister book : Select C"
  echo "To exit            : Select D"

  read -p "Select the option: " option
  case ${option} in
    A) addBook
       ;;
    B) listBooks
       ;;
    C) unRegisterBook
       ;;
    D) echo "Terminating program."
       exit 1
       ;;
    *) echo "Please select one of the option listed."
       esac   
done
}

init