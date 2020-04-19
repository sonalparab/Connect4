type object_phrase = string list

type command = 
  | Print
  | Place of object_phrase
  | Save of object_phrase
  | Load of object_phrase

exception Empty
exception Malformed

let rec parse_helper inputs obj_phrase =
  match inputs with 
  | [] -> List.rev obj_phrase
  | h::t -> if h = "" then parse_helper t obj_phrase else
      parse_helper t (h::obj_phrase)

let parse input = 
  let words = String.split_on_char ' ' input in 
  match words with 
  | [] -> raise Empty
  | h::t ->
    if h = "print" then Print else
    if h = "place" then Place (parse_helper t []) else
    if h = "save" then Save (parse_helper t []) else
    if h = "load" then Load (parse_helper t []) else
      raise Malformed