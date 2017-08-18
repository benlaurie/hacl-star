module Curve25519

module ST = FStar.HyperStack.ST
// BB: This is not needed. Remove.

open FStar.HyperStack.All

open FStar.Mul
open FStar.HyperStack
open FStar.Ghost
open FStar.Buffer
open FStar.Buffer.Quantifiers
// BB: Those 'open' are not all required. Remove.

#reset-options "--max_fuel 0 --z3rlimit 20"

let crypto_scalarmult mypublic secret basepoint =  Hacl.EC.crypto_scalarmult mypublic secret basepoint
