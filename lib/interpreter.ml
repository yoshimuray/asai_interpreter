type expr_t = 
  | Number of int
  | Plus of expr_t * expr_t
  | Minus of expr_t * expr_t
  | Times of expr_t * expr_t
  | Divide of expr_t * expr_t
  | Mod of expr_t * expr_t
  | Bool of bool
  | And of expr_t * expr_t
  | Or of expr_t * expr_t
  | Not of expr_t

type value_t =
  | VNumber of int
  | VBool of bool

let rec eval e =
  match e with
  | Number n -> VNumber n
  | Bool b -> VBool b
  | Plus (e1, e2) -> (
    match (eval e1, eval e2) with
    | (VNumber n1, VNumber n2) -> VNumber (n1 + n2)
    | _ -> failwith "Type error in Plus")
  | Minus (e1, e2) -> (
    match (eval e1, eval e2) with
    | (VNumber n1, VNumber n2) -> VNumber (n1 - n2)
    | _ -> failwith "Type error in Minus" )
  | Times (e1, e2) -> (
    match (eval e1, eval e2) with
    | (VNumber n1, VNumber n2) -> VNumber (n1 * n2)
    | _ -> failwith "Type error in Times" )
  | Divide (e1, e2) -> (
    match (eval e1, eval e2) with
    | (VNumber n1, VNumber n2) -> VNumber (n1 / n2)
    | _ -> failwith "Type error in Divide )" )
  | Mod (e1, e2) -> (
    match (eval e1, eval e2) with
    | (VNumber n1, VNumber n2) -> VNumber (n1 mod n2)
    | _ -> failwith "Type error in Mod" )
  | And (e1, e2) -> (
    match (eval e1, eval e2) with
    | (VBool b1, VBool b2) -> VBool (b1 && b2)
    | _ -> failwith "Type error in And" )
  | Or (e1, e2) -> (
    match (eval e1, eval e2) with
    | (VBool b1, VBool b2) -> VBool (b1 || b2)
    | _ -> failwith "Type error in Or" )
  | Not e1 -> (
    match eval e1 with
    | VBool b -> VBool (not b)
    | _ -> failwith "Type error in Not" )

(* Tests *)
let%test _ = 
  eval (Plus (Number 3, Times (Number 4, Minus (Number 5, Number 2))))
  = VNumber 15
let%test _ =
  eval (Or (Bool true, And (Not (Bool false), Bool true)))
  = VBool true
