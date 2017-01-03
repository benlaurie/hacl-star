module Hacl.EC.Curve25519.Bignum.Fproduct.Lemmas

open FStar.Mul
open FStar.ST
open FStar.HyperStack
open FStar.Ghost
open FStar.Buffer
open FStar.Math.Lib
open FStar.Math.Lemmas

open Hacl.UInt64

open Hacl.EC.Curve25519.Parameters
open Hacl.EC.Curve25519.Bigint
open Hacl.EC.Curve25519.Bignum.Lemmas.Utils

module U8  = FStar.UInt8
module U32 = FStar.UInt32
module H8  = Hacl.UInt8
module H32  = Hacl.UInt32
module H64  = Hacl.UInt64


#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

let isMultiplication (h0:mem) (h1:mem) (a:bigint) (b:bigint) (c:bigint_wide) : GTot Type0 =
  live h0 a /\ live h0 b /\ live h1 c
  /\ length c >= 2*norm_length-1
  /\ (
    let a0 = v (get h0 a 0) in let a1 = v (get h0 a 1) in let a2 = v (get h0 a 2) in
    let a3 = v (get h0 a 3) in let a4 = v (get h0 a 4) in let b0 = v (get h0 b 0) in
    let b1 = v (get h0 b 1) in let b2 = v (get h0 b 2) in let b3 = v (get h0 b 3) in
    let b4 = v (get h0 b 4) in 
    let open Hacl.UInt128 in
    let c0 = v (get h1 c 0) in let c1 = v (get h1 c 1) in
    let c2 = v (get h1 c 2) in let c3 = v (get h1 c 3) in let c4 = v (get h1 c 4) in
    let c5 = v (get h1 c 5) in let c6 = v (get h1 c 6) in let c7 = v (get h1 c 7) in
    let c8 = v (get h1 c 8) in
    ( c0 = a0 * b0
      /\ c1 = a0 * b1 + a1 * b0
      /\ c2 = a0 * b2 + a1 * b1 + a2 * b0
      /\ c3 = a0 * b3 + a1 * b2 + a2 * b1 + a3 * b0
      /\ c4 = a0 * b4 + a1 * b3 + a2 * b2 + a3 * b1 + a4 * b0
      /\ c5 = a1 * b4 + a2 * b3 + a3 * b2 + a4 * b1
      /\ c6 = a2 * b4 + a3 * b3 + a4 * b2
      /\ c7 = a3 * b4 + a4 * b3
      /\ c8 = a4 * b4 ) )

let isMultiplication_
  (h1:mem)
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int)
  (c:bigint_wide) : GTot Type0 =
  live h1 c /\ length c >= 2*norm_length-1
  /\ ( let open Hacl.UInt128 in
      let c0 = v (get h1 c 0) in let c1 = v (get h1 c 1) in
      let c2 = v (get h1 c 2) in let c3 = v (get h1 c 3) in let c4 = v (get h1 c 4) in
      let c5 = v (get h1 c 5) in let c6 = v (get h1 c 6) in let c7 = v (get h1 c 7) in
      let c8 = v (get h1 c 8) in
      ( c0 = a0 * b0
	/\ c1 = a0 * b1 + a1 * b0
	/\ c2 = a0 * b2 + a1 * b1 + a2 * b0
	/\ c3 = a0 * b3 + a1 * b2 + a2 * b1 + a3 * b0
	/\ c4 = a0 * b4 + a1 * b3 + a2 * b2 + a3 * b1 + a4 * b0
	/\ c5 = a1 * b4 + a2 * b3 + a3 * b2 + a4 * b1
	/\ c6 = a2 * b4 + a3 * b3 + a4 * b2
	/\ c7 = a3 * b4 + a4 * b3
	/\ c8 = a4 * b4 ) )


#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

val lemma_multiplication_0:
  a0:H64.t -> a1:H64.t -> a2:H64.t -> a3:H64.t -> a4:H64.t ->
  b0:H64.t -> b1:H64.t -> b2:H64.t -> b3:H64.t -> b4:H64.t ->
  Lemma (requires (
	  v a0 < pow2 51 /\ v a1 < pow2 51 /\ v a2 < pow2 51 /\ v a3 < pow2 51 /\ v a4 < pow2 51
	  /\ v b0 < pow2 51 /\ v b1 < pow2 51 /\ v b2 < pow2 51 /\ v b3 < pow2 51 /\ v b4 < pow2 51))
	(ensures  (
	  v a0 * v b0 < pow2 128 /\ v a1 * v b0 < pow2 128 /\ v a2 * v b0 < pow2 128
	  /\ v a3 * v b0 < pow2 128 /\ v a4 * v b0 < pow2 128 /\ v a0 * v b1 < pow2 128
	  /\ v a1 * v b1 < pow2 128 /\ v a2 * v b1 < pow2 128 /\ v a3 * v b1 < pow2 128
	  /\ v a4 * v b1 < pow2 128 /\ v a0 * v b2 < pow2 128 /\ v a1 * v b2 < pow2 128
	  /\ v a2 * v b2 < pow2 128 /\ v a3 * v b2 < pow2 128 /\ v a4 * v b2 < pow2 128
	  /\ v a0 * v b3 < pow2 128 /\ v a1 * v b3 < pow2 128 /\ v a2 * v b3 < pow2 128
	  /\ v a3 * v b3 < pow2 128 /\ v a4 * v b3 < pow2 128 /\ v a0 * v b4 < pow2 128
	  /\ v a1 * v b4 < pow2 128 /\ v a2 * v b4 < pow2 128 /\ v a3 * v b4 < pow2 128
	  /\ v a4 * v b4 < pow2 128
	  /\ v a0 * v b1 + v a1 * v b0 < pow2 128
	  /\ v a0 * v b2 + v a1 * v b1 < pow2 128
	  /\ v a0 * v b2 + v a1 * v b1 + v a2 * v b0 < pow2 128
	  /\ v a0 * v b3 + v a1 * v b2 < pow2 128
	  /\ v a0 * v b3 + v a1 * v b2 + v a2 * v b1 < pow2 128
	  /\ v a0 * v b3 + v a1 * v b2 + v a2 * v b1 + v a3 * v b0 < pow2 128
	  /\ v a0 * v b4 + v a1 * v b3 < pow2 128
	  /\ v a0 * v b4 + v a1 * v b3 + v a2 * v b2 < pow2 128
	  /\ v a0 * v b4 + v a1 * v b3 + v a2 * v b2 + v a3 * v b1 < pow2 128
	  /\ v a0 * v b4 + v a1 * v b3 + v a2 * v b2 + v a3 * v b1 + v a4 * v b0 < pow2 128
	  /\ v a1 * v b4 + v a2 * v b3 < pow2 128
	  /\ v a1 * v b4 + v a2 * v b3 + v a3 * v b2 < pow2 128
	  /\ v a1 * v b4 + v a2 * v b3 + v a3 * v b2 + v a4 * v b1 < pow2 128
	  /\ v a2 * v b4 + v a3 * v b3 < pow2 128
	  /\ v a2 * v b4 + v a3 * v b3 + v a4 * v b2 < pow2 128
	  /\ v a3 * v b4 + v a4 * v b3 < pow2 128
	  ))
let lemma_multiplication_0 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4 =
  assert(forall (a:nat) (b:nat) c d. {:pattern (a * b); (c * d)} (a < c /\ b < d) ==> a * b < c * d);
  pow2_plus 51 51;
  pow2_lt_compat 128 102;
  pow2_double_sum 102;
  pow2_lt_compat 128 102;
  pow2_double_sum 103;
  pow2_lt_compat 128 104;
  pow2_double_sum 104;
  pow2_lt_compat 128 105


#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

let u51 = x:Hacl.UInt64.t{v x < pow2 51}


let lemma_multiplication00 a b c :
  Lemma (a * (b + c) = a * b + a * c)
  = ()
let lemma_multiplication01 a b c d:
  Lemma (a * (b + c + d) = a * b + a * c + a * d)
  = ()
let lemma_multiplication02 a b c d e :
  Lemma (a * (b + c + d + e) = a * b + a * c + a * d + a * e)
  = ()
let lemma_multiplication03 a b c d e f :
  Lemma (a * (b + c + d + e + f) = a * b + a * c + a * d + a * e + a * f)
  = ()
private let lemma_multiplication03bis a b c d e f :
  Lemma ((b + c + d + e + f) * a = b * a + c * a + d * a + e * a + f * a)
  = ()
private let lemma_multiplication04 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4 :
  Lemma ((a0+a1+a2+a3+a4)*(b0+b1+b2+b3+b4)
    = a0*b0+a0*b1+a0*b2+a0*b3+a0*b4
      +a1*b0+a1*b1+a1*b2+a1*b3+a1*b4
      +a2*b0+a2*b1+a2*b2+a2*b3+a2*b4
      +a3*b0+a3*b1+a3*b2+a3*b3+a3*b4
      +a4*b0+a4*b1+a4*b2+a4*b3+a4*b4)
  = lemma_multiplication03bis (b0+b1+b2+b3+b4) a0 a1 a2 a3 a4;
    lemma_multiplication03 a0 b0 b1 b2 b3 b4;
    lemma_multiplication03 a1 b0 b1 b2 b3 b4;
    lemma_multiplication03 a2 b0 b1 b2 b3 b4;
    lemma_multiplication03 a3 b0 b1 b2 b3 b4;
    lemma_multiplication03 a4 b0 b1 b2 b3 b4

#reset-options "--z3rlimit 5 --initial_fuel 0 --max_fuel 0"

let lemma_multiplication05
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma ((a0 + pow2 51 * a1 + pow2 102 * a2 + pow2 153 * a3 + pow2 204 * a4)
    * (b0 + pow2 51 * b1 + pow2 102 * b2 + pow2 153 * b3 + pow2 204 * b4)
    = a0*b0+a0*(pow2 51*b1)+a0*(pow2 102*b2)+a0*(pow2 153*b3)+a0*(pow2 204*b4)
      +(pow2 51*a1)*b0+(pow2 51*a1)*(pow2 51*b1)+(pow2 51*a1)*(pow2 102*b2)+(pow2 51*a1)*(pow2 153*b3)+(pow2 51*a1)*(pow2 204*b4)
      +(pow2 102*a2)*b0+(pow2 102*a2)*(pow2 51*b1)+(pow2 102*a2)*(pow2 102*b2)+(pow2 102*a2)*(pow2 153*b3)+(pow2 102*a2)*(pow2 204*b4)
      +(pow2 153*a3)*b0+(pow2 153*a3)*(pow2 51*b1)+(pow2 153*a3)*(pow2 102*b2)+(pow2 153*a3)*(pow2 153*b3)+(pow2 153*a3)*(pow2 204*b4)
      +(pow2 204*a4)*b0+(pow2 204*a4)*(pow2 51*b1)+(pow2 204*a4)*(pow2 102*b2) +(pow2 204*a4)*(pow2 153*b3)+(pow2 204*a4)*(pow2 204*b4) )
  = lemma_multiplication04 (a0) (pow2 51 * a1) (pow2 102 * a2) (pow2 153 * a3) (pow2 204 * a4)
			   (b0) (pow2 51 * b1) (pow2 102 * b2) (pow2 153 * b3) (pow2 204 * b4)


#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

private let lemma_multiplication060
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma (
    a0*b0+a0*(pow2 51*b1)+a0*(pow2 102*b2)+a0*(pow2 153*b3)+a0*(pow2 204*b4)
    = a0 * b0 + pow2 51  * (a0 * b1) + pow2 102  * (a0 * b2) + pow2 153  * (a0 * b3) + pow2 204 * (a0 * b4) )
  = ()

#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

let lemma_swap p1 a p2 b : Lemma ((p1 * a) * (p2 * b) = p1 * p2 * (a * b)) = ()


private let lemma_multiplication061
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma (
    (pow2 51*a1)*b0+(pow2 51*a1)*(pow2 51*b1)+(pow2 51*a1)*(pow2 102*b2)+(pow2 51*a1)*(pow2 153*b3)+(pow2 51*a1)*(pow2 204*b4)
    = pow2 51 * (a1 * b0) + pow2 102 * (a1 * b1) + pow2 153 * (a1 * b2) + pow2 204 * (a1 * b3) + pow2 255 * (a1 * b4) )
  = pow2_plus 51 51;
    pow2_plus 51 102;
    pow2_plus 51 153;
    pow2_plus 51 204;
    lemma_swap (pow2 51) a1 (pow2 51) b1;
    lemma_swap (pow2 51) a1 (pow2 102) b2;
    lemma_swap (pow2 51) a1 (pow2 153) b3;
    lemma_swap (pow2 51) a1 (pow2 204) b4


#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

private let lemma_multiplication062
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma (
    (pow2 102*a2)*b0+(pow2 102*a2)*(pow2 51*b1)+(pow2 102*a2)*(pow2 102*b2)+(pow2 102*a2)*(pow2 153*b3)+(pow2 102*a2)*(pow2 204*b4)
    = pow2 102  * (a2 * b0) + pow2 153  * (a2 * b1) + pow2 204 * (a2 * b2) + pow2 255 * (a2 * b3) + pow2 306 * (a2 * b4) )
  = pow2_plus 102 51;
    pow2_plus 102 102;
    pow2_plus 102 153;
    pow2_plus 102 204;
    lemma_swap (pow2 102) a2 (pow2 51) b1;
    lemma_swap (pow2 102) a2 (pow2 102) b2;
    lemma_swap (pow2 102) a2 (pow2 153) b3;
    lemma_swap (pow2 102) a2 (pow2 204) b4

#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

private let lemma_multiplication063
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma (
    (pow2 153*a3)*b0+(pow2 153*a3)*(pow2 51*b1)+(pow2 153*a3)*(pow2 102*b2)+(pow2 153*a3)*(pow2 153*b3)+(pow2 153*a3)*(pow2 204*b4)
    = pow2 153  * (a3 * b0) + pow2 204 * (a3 * b1) + pow2 255 * (a3 * b2) + pow2 306 * (a3 * b3) + pow2 357 * (a3 * b4) )
  = pow2_plus 153 51;
    pow2_plus 153 102;
    pow2_plus 153 153;
    pow2_plus 153 204;
    lemma_swap (pow2 153) a3 (pow2 51) b1;
    lemma_swap (pow2 153) a3 (pow2 102) b2;
    lemma_swap (pow2 153) a3 (pow2 153) b3;
    lemma_swap (pow2 153) a3 (pow2 204) b4

#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

private let lemma_multiplication064
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma (
    (pow2 204*a4)*b0+(pow2 204*a4)*(pow2 51*b1)+(pow2 204*a4)*(pow2 102*b2) +(pow2 204*a4)*(pow2 153*b3)+(pow2 204*a4)*(pow2 204*b4)
    = pow2 204 * (a4 * b0) + pow2 255 * (a4 * b1) + pow2 306 * (a4 * b2) + pow2 357 * (a4 * b3) + pow2 408 * (a4 * b4) )
  = pow2_plus 204 51;
    pow2_plus 204 102;
    pow2_plus 204 153;
    pow2_plus 204 204;
    lemma_swap (pow2 204) a4 (pow2 51) b1;
    lemma_swap (pow2 204) a4 (pow2 102) b2;
    lemma_swap (pow2 204) a4 (pow2 153) b3;
    lemma_swap (pow2 204) a4 (pow2 204) b4

#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

private let lemma_multiplication06
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma (
    a0*b0+a0*(pow2 51*b1)+a0*(pow2 102*b2)+a0*(pow2 153*b3)+a0*(pow2 204*b4)
      +(pow2 51*a1)*b0+(pow2 51*a1)*(pow2 51*b1)+(pow2 51*a1)*(pow2 102*b2)+(pow2 51*a1)*(pow2 153*b3)+(pow2 51*a1)*(pow2 204*b4)
      +(pow2 102*a2)*b0+(pow2 102*a2)*(pow2 51*b1)+(pow2 102*a2)*(pow2 102*b2)+(pow2 102*a2)*(pow2 153*b3)+(pow2 102*a2)*(pow2 204*b4)
      +(pow2 153*a3)*b0+(pow2 153*a3)*(pow2 51*b1)+(pow2 153*a3)*(pow2 102*b2)+(pow2 153*a3)*(pow2 153*b3)+(pow2 153*a3)*(pow2 204*b4)
      +(pow2 204*a4)*b0+(pow2 204*a4)*(pow2 51*b1)+(pow2 204*a4)*(pow2 102*b2) +(pow2 204*a4)*(pow2 153*b3)+(pow2 204*a4)*(pow2 204*b4)
    =              (a0 * b0) + pow2 51  * (a0 * b1) + pow2 102  * (a0 * b2) + pow2 153  * (a0 * b3) + pow2 204 * (a0 * b4)
      + pow2 51  * (a1 * b0) + pow2 102  * (a1 * b1) + pow2 153  * (a1 * b2) + pow2 204 * (a1 * b3) + pow2 255 * (a1 * b4)
      + pow2 102  * (a2 * b0) + pow2 153  * (a2 * b1) + pow2 204 * (a2 * b2) + pow2 255 * (a2 * b3) + pow2 306 * (a2 * b4)
      + pow2 153  * (a3 * b0) + pow2 204 * (a3 * b1) + pow2 255 * (a3 * b2) + pow2 306 * (a3 * b3) + pow2 357 * (a3 * b4)
      + pow2 204 * (a4 * b0) + pow2 255 * (a4 * b1) + pow2 306 * (a4 * b2) + pow2 357 * (a4 * b3) + pow2 408 * (a4 * b4) )
  = lemma_multiplication060 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4;
    lemma_multiplication061 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4;
    lemma_multiplication062 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4;
    lemma_multiplication063 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4;
    lemma_multiplication064 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4

#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

private let lemma_multiplication07
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma ((a0 + pow2 51 * a1 + pow2 102 * a2 + pow2 153 * a3 + pow2 204 * a4)
    * (b0 + pow2 51 * b1 + pow2 102 * b2 + pow2 153 * b3 + pow2 204 * b4)
    =              (a0 * b0) + pow2 51  * (a0 * b1) + pow2 102  * (a0 * b2) + pow2 153  * (a0 * b3) + pow2 204 * (a0 * b4)
      + pow2 51  * (a1 * b0) + pow2 102  * (a1 * b1) + pow2 153  * (a1 * b2) + pow2 204 * (a1 * b3) + pow2 255 * (a1 * b4)
      + pow2 102  * (a2 * b0) + pow2 153  * (a2 * b1) + pow2 204 * (a2 * b2) + pow2 255 * (a2 * b3) + pow2 306 * (a2 * b4)
      + pow2 153  * (a3 * b0) + pow2 204 * (a3 * b1) + pow2 255 * (a3 * b2) + pow2 306 * (a3 * b3) + pow2 357 * (a3 * b4)
      + pow2 204 * (a4 * b0) + pow2 255 * (a4 * b1) + pow2 306 * (a4 * b2) + pow2 357 * (a4 * b3) + pow2 408 * (a4 * b4) )
  = lemma_multiplication05 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4;
    lemma_multiplication06 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4

#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

private let lemma_multiplication08
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma (
    a0 * b0 + pow2 51  * (a1 * b0 + a0 * b1)
	    + pow2 102  * (a2 * b0 + a1 * b1 + a0 * b2)
	    + pow2 153  * (a3 * b0 + a2 * b1 + a1 * b2 + a0 * b3)
	    + pow2 204 * (a4 * b0 + a3 * b1 + a2 * b2 + a1 * b3 + a0 * b4)
	    + pow2 255 * (a4 * b1 + a3 * b2 + a2 * b3 + a1 * b4)
	    + pow2 306 * (a4 * b2 + a3 * b3 + a2 * b4)
	    + pow2 357 * (a4 * b3 + a3 * b4)
	    + pow2 408 * (a4 * b4)
    =              (a0 * b0) + pow2 51  * (a0 * b1) + pow2 102  * (a0 * b2) + pow2 153  * (a0 * b3) + pow2 204 * (a0 * b4)
      + pow2 51  * (a1 * b0) + pow2 102  * (a1 * b1) + pow2 153  * (a1 * b2) + pow2 204 * (a1 * b3) + pow2 255 * (a1 * b4)
      + pow2 102  * (a2 * b0) + pow2 153  * (a2 * b1) + pow2 204 * (a2 * b2) + pow2 255 * (a2 * b3) + pow2 306 * (a2 * b4)
      + pow2 153  * (a3 * b0) + pow2 204 * (a3 * b1) + pow2 255 * (a3 * b2) + pow2 306 * (a3 * b3) + pow2 357 * (a3 * b4)
      + pow2 204 * (a4 * b0) + pow2 255 * (a4 * b1) + pow2 306 * (a4 * b2) + pow2 357 * (a4 * b3) + pow2 408 * (a4 * b4) )
  = lemma_multiplication00 (pow2 51) (a1 * b0) (a0 * b1);
    lemma_multiplication01 (pow2 102) (a2 * b0) (a1 * b1) (a0 * b2);
    lemma_multiplication02 (pow2 153) (a3 * b0) (a2 * b1) (a1 * b2) (a0 * b3);
    lemma_multiplication03 (pow2 204) (a4 * b0) (a3 * b1) (a2 * b2) (a1 * b3) (a0 * b4);
    lemma_multiplication02 (pow2 255) (a4 * b1) (a3 * b2) (a2 * b3) (a1 * b4);
    lemma_multiplication01 (pow2 306) (a4 * b2) (a3 * b3) (a2 * b4);
    lemma_multiplication00 (pow2 357) (a4 * b3) (a3 * b4)


#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

private let lemma_multiplication0
  (a0:int) (a1:int) (a2:int) (a3:int) (a4:int)
  (b0:int) (b1:int) (b2:int) (b3:int) (b4:int) :
  Lemma (
    (a0 + pow2 51 * a1 + pow2 102 * a2 + pow2 153 * a3 + pow2 204 * a4)
    * (b0 + pow2 51 * b1 + pow2 102 * b2 + pow2 153 * b3 + pow2 204 * b4) =
    a0 * b0 + pow2 51  * (a1 * b0 + a0 * b1)
	    + pow2 102  * (a2 * b0 + a1 * b1 + a0 * b2)
	    + pow2 153  * (a3 * b0 + a2 * b1 + a1 * b2 + a0 * b3)
	    + pow2 204 * (a4 * b0 + a3 * b1 + a2 * b2 + a1 * b3 + a0 * b4)
	    + pow2 255 * (a4 * b1 + a3 * b2 + a2 * b3 + a1 * b4)
	    + pow2 306 * (a4 * b2 + a3 * b3 + a2 * b4)
	    + pow2 357 * (a4 * b3 + a3 * b4)
	    + pow2 408 * (a4 * b4) )
  = lemma_multiplication07 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4;
    lemma_multiplication08 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4


#reset-options "--z3rlimit 20 --initial_fuel 0 --max_fuel 0"

val lemma_multiplication1:
  h0:mem -> h1:mem ->
  c:bigint_wide{length c >= 2*norm_length-1} ->
  a:bigint -> b:bigint ->
  Lemma (requires (isMultiplication h0 h1 a b c))
	(ensures  (isMultiplication h0 h1 a b c
	  /\ eval_wide h1 c (2*norm_length-1) = eval h0 a norm_length * eval h0 b norm_length))
let lemma_multiplication1 h0 h1 c a b =
  let a0 = v (get h0 a 0) in
  let a1 = v (get h0 a 1) in
  let a2 = v (get h0 a 2) in
  let a3 = v (get h0 a 3) in
  let a4 = v (get h0 a 4) in
  let b0 = v (get h0 b 0) in
  let b1 = v (get h0 b 1) in
  let b2 = v (get h0 b 2) in
  let b3 = v (get h0 b 3) in
  let b4 = v (get h0 b 4) in
  lemma_eval_bigint_wide_9 h1 c;
  lemma_eval_bigint_5 h0 a;
  lemma_eval_bigint_5 h0 b;
  lemma_multiplication0 a0 a1 a2 a3 a4 b0 b1 b2 b3 b4


#reset-options "--z3rlimit 100 --initial_fuel 0 --max_fuel 0"

let lemma_mul_ineq (a:nat) (b:nat) c d : Lemma (requires (a < c /\ b < d))
					    (ensures  (a * b < c * d))
  = ()

val lemma_multiplication2:
  h0:mem -> h1:mem ->
  c:bigint_wide{length c >= 2*norm_length-1} ->
  a:bigint -> b:bigint ->
  Lemma (requires (norm h0 a /\ norm h0 b /\ isMultiplication h0 h1 a b c))
	(ensures  (norm h0 a /\ norm h0 b /\ isMultiplication h0 h1 a b c
	  /\ maxValue_wide h1 c 9 <= norm_length * pow2 102))
let lemma_multiplication2 h0 h1 c a b =
  pow2_plus 51 51;
  let a0 = v (get h0 a 0) in
  let a1 = v (get h0 a 1) in
  let a2 = v (get h0 a 2) in
  let a3 = v (get h0 a 3) in
  let a4 = v (get h0 a 4) in
  let b0 = v (get h0 b 0) in
  let b1 = v (get h0 b 1) in
  let b2 = v (get h0 b 2) in
  let b3 = v (get h0 b 3) in
  let b4 = v (get h0 b 4) in
  lemma_mul_ineq a0 b0 (pow2 51) (pow2 51);
  lemma_mul_ineq a0 b1 (pow2 51) (pow2 51);
  lemma_mul_ineq a0 b2 (pow2 51) (pow2 51);
  lemma_mul_ineq a0 b3 (pow2 51) (pow2 51);
  lemma_mul_ineq a0 b4 (pow2 51) (pow2 51);
  lemma_mul_ineq a1 b0 (pow2 51) (pow2 51);
  lemma_mul_ineq a1 b1 (pow2 51) (pow2 51);
  lemma_mul_ineq a1 b2 (pow2 51) (pow2 51);
  lemma_mul_ineq a1 b3 (pow2 51) (pow2 51);
  lemma_mul_ineq a1 b4 (pow2 51) (pow2 51);
  lemma_mul_ineq a2 b0 (pow2 51) (pow2 51);
  lemma_mul_ineq a2 b1 (pow2 51) (pow2 51);
  lemma_mul_ineq a2 b2 (pow2 51) (pow2 51);
  lemma_mul_ineq a2 b3 (pow2 51) (pow2 51);
  lemma_mul_ineq a2 b4 (pow2 51) (pow2 51);
  lemma_mul_ineq a3 b0 (pow2 51) (pow2 51);
  lemma_mul_ineq a3 b1 (pow2 51) (pow2 51);
  lemma_mul_ineq a3 b2 (pow2 51) (pow2 51);
  lemma_mul_ineq a3 b3 (pow2 51) (pow2 51);
  lemma_mul_ineq a3 b4 (pow2 51) (pow2 51);
  lemma_mul_ineq a4 b0 (pow2 51) (pow2 51);
  lemma_mul_ineq a4 b1 (pow2 51) (pow2 51);
  lemma_mul_ineq a4 b2 (pow2 51) (pow2 51);
  lemma_mul_ineq a4 b3 (pow2 51) (pow2 51);
  lemma_mul_ineq a4 b4 (pow2 51) (pow2 51);
  let open Hacl.UInt128 in
  assert(v (get h1 c 0) < pow2 102);
  assert(v (get h1 c 1) < 2*pow2 102);
  assert(v (get h1 c 2) < 3*pow2 102);
  assert(v (get h1 c 3) < 4*pow2 102);
  assert(v (get h1 c 4) < 5*pow2 102);
  assert(v (get h1 c 5) < 4*pow2 102);
  assert(v (get h1 c 6) < 3*pow2 102);
  assert(v (get h1 c 7) < 2*pow2 102);
  assert(v (get h1 c 8) < pow2 102);
  maxValue_wide_bound_lemma_aux h1 c (2*norm_length-1) (5*pow2 102)


#reset-options "--z3rlimit 5 --initial_fuel 0 --max_fuel 0"

val lemma_multiplication:
  h0:mem ->
  h1:mem ->
  c:bigint_wide{length c >= 2*norm_length-1} ->
  a:bigint{disjoint c a} ->
  b:bigint{disjoint c b} ->
  Lemma (requires (norm h0 a /\ norm h0 b /\ live h1 c /\ isMultiplication h0 h1 a b c))
	(ensures  (norm h0 a /\ norm h0 b /\ live h1 c /\ isMultiplication h0 h1 a b c
	  /\ eval_wide h1 c (2*norm_length-1) = eval h0 a norm_length * eval h0 b norm_length
	  /\ maxValue_wide h1 c (2*norm_length-1) <= norm_length * pow2 102))
let lemma_multiplication h0 h1 c a b =
  lemma_multiplication1 h0 h1 c a b;
  lemma_multiplication2 h0 h1 c a b