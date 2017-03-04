module Spec.Chacha.Lemmas

open FStar.Mul
open FStar.Seq
open FStar.UInt32
open FStar.Endianness
open Spec.Lib

open Spec.Chacha20
open Spec.Chacha20_vec

module S = Spec.Chacha20
module V = Spec.Chacha20_vec

let state = S.state
let vec_state = V.state

#set-options "--initial_fuel 0 --max_fuel 0 --initial_ifuel 0 --max_ifuel 0 --z3rlimit 100"

abstract
let create_4 (#a:Type) (x0:a) (x1:a) (x2:a) (x3:a) :
  Tot (s:seq a{length s = 4 /\ index s 0 == x0 /\ index s 1 == x1 /\ index s 2 == x2 /\ index s 3 == x3})
  = let s = create 4 x0 in
    let s = upd s 1 x1 in
    let s = upd s 2 x2 in
    let s = upd s 3 x3 in
    s


let state_to_vec_state (s:state) : Tot vec_state =
  let s0 = slice s 0  4  in
  let s1 = slice s 4  8  in
  let s2 = slice s 8  12 in
  let s3 = slice s 12 16 in
  create_4 s0 s1 s2 s3


let vec_state_to_state (s:vec_state) : Tot state =
  let s0 = index s 0 in
  let s1 = index s 1 in
  let s2 = index s 2 in
  let s3 = index s 3 in
  s0 @| s1 @| s2 @| s3


val lemma_state (s:state) : Lemma (vec_state_to_state (state_to_vec_state s) == s)
let lemma_state s =
  let s0 = slice s 0  4  in
  let s1 = slice s 4  8  in
  let s2 = slice s 8  12 in
  let s3 = slice s 12 16 in
  lemma_eq_intro (s0 @| s1 @| s2 @| s3) s


val lemma_vec_state (s:vec_state) : Lemma (state_to_vec_state (vec_state_to_state s) == s)
let lemma_vec_state s =
  let s0 = index s 0 in
  let s1 = index s 1 in
  let s2 = index s 2 in
  let s3 = index s 3 in
  let s' = s0 @| s1 @| s2 @| s3 in
  lemma_eq_intro (slice s' 0   4) s0;
  lemma_eq_intro (slice s' 4   8) s1;
  lemma_eq_intro (slice s' 8  12) s2;
  lemma_eq_intro (slice s' 12 16) s3;
  lemma_eq_intro (create_4 s0 s1 s2 s3) (s)


let quarter_round_vec (s:vec_state) : Tot vec_state =
  let s = V.line 0 1 3 16ul s in
  let s = V.line 2 3 1 12ul s in
  let s = V.line 0 1 3 8ul  s in
  let s = V.line 2 3 1 7ul  s in
  s


let lined (a:t) (b:t) (c:t) (d:t) (a1:t) (b1:t) (c1:t) (d1:t) : GTot Type0 =
  let open FStar.UInt32 in
  let a' = a +%^ b in
  let d' = Spec.Lib.rotate_left (d ^^ a') 16ul in
  let c' = c +%^ d' in
  let b' = Spec.Lib.rotate_left (b ^^ c') 12ul in
  let a'' = a' +%^ b' in
  let d'' = Spec.Lib.rotate_left (d' ^^ a'') 8ul in
  let c'' = c' +%^ d'' in
  let b'' = Spec.Lib.rotate_left (b' ^^ c'') 7ul in
  a1 == a'' /\ b1 == b'' /\ c1 == c'' /\ d1 == d''


val line_: a:S.idx -> b:S.idx -> d:S.idx -> ss:UInt32.t {v ss < 32} -> s:state -> Tot (s':state{s' == S.line a b d ss s})
let line_ a b d s m =
  let open FStar.UInt32 in
  let m = upd m a (index m a +%^ index m b) in
  let m = upd m d (Spec.Lib.rotate_left (index m d ^^  index m a) s) in
  m


#set-options "--initial_fuel 0 --max_fuel 0 --z3rlimit 500"


let new_line (s:state) (a:S.idx) (b:S.idx) (d:S.idx{a <> b /\ a <> d /\ b <> d}) (ss:UInt32.t{UInt32.v ss < 32}) : Tot (s':state{
  let sa = index s a in let sb = index s b in let sd = index s d in
  let sa' = index s' a in let sb' = index s' b in let sd' = index s' d in
  let open FStar.UInt32 in
  let a' = sa +%^ sb in
  let d' = Spec.Lib.rotate_left (sd ^^ a') ss in
  sa' == a' /\ sd' == d'
  /\ (forall (i:nat). {:pattern (index s' i)} (i < 16 /\ i <> a /\ i <> d) ==> index s' i == index s i)
  })
  = line_ a b d ss s


let quarter_round_standard
  (s:state) (a:S.idx) (b:S.idx) (c:S.idx) (d:S.idx{a <> b /\ a <> c /\ a <> d /\ b <> c /\ b <> d /\ c <> d}) :
  Tot (s':state{s' == S.quarter_round a b c d s}) =
  let s = new_line s a b d 16ul in
  let s = new_line s c d b 12ul in
  let s = new_line s a b d 8ul  in
  let s = new_line s c d b 7ul  in
  s


#reset-options "--initial_fuel 0 --max_fuel 0 --z3rlimit 500"

let lemma_quarter_round_standard
  (s:state) (a:S.idx) (b:S.idx) (c:S.idx) (d:S.idx{a <> b /\ a <> c /\ a <> d /\ b <> c /\ b <> d /\ c <> d}) :
  Lemma
  (let s' = quarter_round_standard s a b c d in
   let sa = index s a in let sb = index s b in let sc = index s c in let sd = index s d in
   let sa' = index s' a in let sb' = index s' b in let sc' = index s' c in let sd' = index s' d in
   lined sa sb sc sd sa' sb' sc' sd'
   /\ (forall (i:nat). {:pattern (Seq.index s' i)} (i < 16 /\ i <> a /\ i <> b /\ i <> c /\ i <> d
     ==> index s' i == index s i)))
   = ()


#reset-options "--initial_fuel 0 --max_fuel 0 --z3rlimit 1000"

let lemma_quarter_round_vectorized (s:vec_state) : Lemma
  (let s' = quarter_round_vec s in
   let s0 = index (index s 0) 0 in   let s1 = index (index s 0) 1 in
   let s2 = index (index s 0) 2 in   let s3 = index (index s 0) 3 in
   let s4 = index (index s 1) 0 in   let s5 = index (index s 1) 1 in
   let s6 = index (index s 1) 2 in   let s7 = index (index s 1) 3 in
   let s8 = index (index s 2) 0 in   let s9 = index (index s 2) 1 in
   let s10 = index (index s 2) 2 in  let s11 = index (index s 2) 3 in
   let s12 = index (index s 3) 0 in  let s13 = index (index s 3) 1 in
   let s14 = index (index s 3) 2 in  let s15 = index (index s 3) 3 in
   let s0' = index (index s' 0) 0 in   let s1' = index (index s' 0) 1 in
   let s2' = index (index s' 0) 2 in   let s3' = index (index s' 0) 3 in
   let s4' = index (index s' 1) 0 in   let s5' = index (index s' 1) 1 in
   let s6' = index (index s' 1) 2 in   let s7' = index (index s' 1) 3 in
   let s8' = index (index s' 2) 0 in   let s9' = index (index s' 2) 1 in
   let s10' = index (index s' 2) 2 in  let s11' = index (index s' 2) 3 in
   let s12' = index (index s' 3) 0 in  let s13' = index (index s' 3) 1 in
   let s14' = index (index s' 3) 2 in  let s15' = index (index s' 3) 3 in
   lined s0 s4 s8 s12 s0' s4' s8' s12'
   /\ lined s1 s5 s9 s13 s1' s5' s9' s13'
   /\ lined s2 s6 s10 s14 s2' s6' s10' s14'
   /\ lined s3 s7 s11 s15 s3' s7' s11' s15')
   = ()


#reset-options "--initial_fuel 0 --max_fuel 0 --z3rlimit 1000"

val column_round_standard: s:state -> Tot (s':state{
  (s' == S.column_round s
   /\ (let s0 = index s 0 in   let s1 = index s 1 in
   let s2 = index s 2 in   let s3 = index s 3 in
   let s4 = index s 4 in   let s5 = index s 5 in
   let s6 = index s 6 in   let s7 = index s 7 in
   let s8 = index s 8 in   let s9 = index s 9 in
   let s10 = index s 10 in  let s11 = index s 11 in
   let s12 = index s 12 in  let s13 = index s 13 in
   let s14 = index s 14 in  let s15 = index s 15 in
   let s0' = index s' 0 in   let s1' = index s' 1 in
   let s2' = index s' 2 in   let s3' = index s' 3 in
   let s4' = index s' 4 in   let s5' = index s' 5 in
   let s6' = index s' 6 in   let s7' = index s' 7 in
   let s8' = index s' 8 in   let s9' = index s' 9 in
   let s10' = index s' 10 in  let s11' = index s' 11 in
   let s12' = index s' 12 in  let s13' = index s' 13 in
   let s14' = index s' 14 in  let s15' = index s' 15 in
   lined s0 s4 s8 s12 s0' s4' s8' s12'
   /\ lined s1 s5 s9 s13 s1' s5' s9' s13'
   /\ lined s2 s6 s10 s14 s2' s6' s10' s14'
   /\ lined s3 s7 s11 s15 s3' s7' s11' s15'))})
let column_round_standard s =
  lemma_quarter_round_standard s 0 4 8 12;
  let s' = quarter_round_standard s 0 4 8 12 in
  lemma_quarter_round_standard s' 1 5 9 13;
  let s'' = quarter_round_standard s' 1 5 9 13 in
  lemma_quarter_round_standard s'' 2 6 10 14;
  let s''' = quarter_round_standard s'' 2 6 10 14 in
  lemma_quarter_round_standard s''' 3 7 11 15;
  let s'''' = quarter_round_standard s''' 3 7 11 15 in
  s''''


(* let lemma_column_round_standard (s:state) : Lemma *)
(*   (let s' = column_round s in *)
(*    let s0 = index s 0 in   let s1 = index s 1 in *)
(*    let s2 = index s 2 in   let s3 = index s 3 in *)
(*    let s4 = index s 4 in   let s5 = index s 5 in *)
(*    let s6 = index s 6 in   let s7 = index s 7 in *)
(*    let s8 = index s 8 in   let s9 = index s 9 in *)
(*    let s10 = index s 10 in  let s11 = index s 11 in *)
(*    let s12 = index s 12 in  let s13 = index s 13 in *)
(*    let s14 = index s 14 in  let s15 = index s 15 in *)
(*    let s0' = index s' 0 in   let s1' = index s' 1 in *)
(*    let s2' = index s' 2 in   let s3' = index s' 3 in *)
(*    let s4' = index s' 4 in   let s5' = index s' 5 in *)
(*    let s6' = index s' 6 in   let s7' = index s' 7 in *)
(*    let s8' = index s' 8 in   let s9' = index s' 9 in *)
(*    let s10' = index s' 10 in  let s11' = index s' 11 in *)
(*    let s12' = index s' 12 in  let s13' = index s' 13 in *)
(*    let s14' = index s' 14 in  let s15' = index s' 15 in *)
(*    lined s0 s4 s8 s12 s0' s4' s8' s12' *)
(*    /\ lined s1 s5 s9 s13 s1' s5' s9' s13' *)
(*    /\ lined s2 s6 s10 s14 s2' s6' s10' s14' *)
(*    /\ lined s3 s7 s11 s15 s3' s7' s11' s15') *)
(*    = () *)




(* val lemma_quarter_round: s:state -> *)
(*   Lemma (vec_state_to_state (quarter_round_vec (state_to_vec_state s)) == S.column_round s) *)
(* let lemma_quarter_round s = () *)