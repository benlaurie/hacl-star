module Hacl.Test.SHA2_512

open FStar.HyperStack.All

module ST = FStar.HyperStack.ST

open FStar.Buffer
open FStar.UInt32

module Hash = SHA2_512


val test_1a: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_1a () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 3ul in
  let plaintext = FStar.Buffer.createL [
      0x61uy; 0x62uy; 0x63uy;
    ] in

  let expected = FStar.Buffer.createL [
    0xdduy; 0xafuy; 0x35uy; 0xa1uy; 0x93uy; 0x61uy; 0x7auy; 0xbauy;
    0xccuy; 0x41uy; 0x73uy; 0x49uy; 0xaeuy; 0x20uy; 0x41uy; 0x31uy;
    0x12uy; 0xe6uy; 0xfauy; 0x4euy; 0x89uy; 0xa9uy; 0x7euy; 0xa2uy;
    0x0auy; 0x9euy; 0xeeuy; 0xe6uy; 0x4buy; 0x55uy; 0xd3uy; 0x9auy;
    0x21uy; 0x92uy; 0x99uy; 0x2auy; 0x27uy; 0x4fuy; 0xc1uy; 0xa8uy;
    0x36uy; 0xbauy; 0x3cuy; 0x23uy; 0xa3uy; 0xfeuy; 0xebuy; 0xbduy;
    0x45uy; 0x4duy; 0x44uy; 0x23uy; 0x64uy; 0x3cuy; 0xe8uy; 0x0euy;
    0x2auy; 0x9auy; 0xc9uy; 0x4fuy; 0xa5uy; 0x4cuy; 0xa4uy; 0x9fuy
    ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* Call the hash function *)
  Hash.init state;
  Hash.update_last state plaintext (FStar.Int.Cast.uint32_to_uint64 plaintext_len);
  Hash.finish state output;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 1a") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()


val test_1b: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_1b () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 3ul in
  let plaintext = FStar.Buffer.createL [
      0x61uy; 0x62uy; 0x63uy;
    ] in

  let expected = FStar.Buffer.createL [
    0xdduy; 0xafuy; 0x35uy; 0xa1uy; 0x93uy; 0x61uy; 0x7auy; 0xbauy;
    0xccuy; 0x41uy; 0x73uy; 0x49uy; 0xaeuy; 0x20uy; 0x41uy; 0x31uy;
    0x12uy; 0xe6uy; 0xfauy; 0x4euy; 0x89uy; 0xa9uy; 0x7euy; 0xa2uy;
    0x0auy; 0x9euy; 0xeeuy; 0xe6uy; 0x4buy; 0x55uy; 0xd3uy; 0x9auy;
    0x21uy; 0x92uy; 0x99uy; 0x2auy; 0x27uy; 0x4fuy; 0xc1uy; 0xa8uy;
    0x36uy; 0xbauy; 0x3cuy; 0x23uy; 0xa3uy; 0xfeuy; 0xebuy; 0xbduy;
    0x45uy; 0x4duy; 0x44uy; 0x23uy; 0x64uy; 0x3cuy; 0xe8uy; 0x0euy;
    0x2auy; 0x9auy; 0xc9uy; 0x4fuy; 0xa5uy; 0x4cuy; 0xa4uy; 0x9fuy
    ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* Call the hash function *)
  Hash.hash output plaintext plaintext_len;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 1b") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()



val test_2a: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_2a () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 0ul in
  let plaintext = FStar.Buffer.createL [] in

  let expected = FStar.Buffer.createL [
    0xcfuy; 0x83uy; 0xe1uy; 0x35uy; 0x7euy; 0xefuy; 0xb8uy; 0xbduy;
    0xf1uy; 0x54uy; 0x28uy; 0x50uy; 0xd6uy; 0x6duy; 0x80uy; 0x07uy;
    0xd6uy; 0x20uy; 0xe4uy; 0x05uy; 0x0buy; 0x57uy; 0x15uy; 0xdcuy;
    0x83uy; 0xf4uy; 0xa9uy; 0x21uy; 0xd3uy; 0x6cuy; 0xe9uy; 0xceuy;
    0x47uy; 0xd0uy; 0xd1uy; 0x3cuy; 0x5duy; 0x85uy; 0xf2uy; 0xb0uy;
    0xffuy; 0x83uy; 0x18uy; 0xd2uy; 0x87uy; 0x7euy; 0xecuy; 0x2fuy;
    0x63uy; 0xb9uy; 0x31uy; 0xbduy; 0x47uy; 0x41uy; 0x7auy; 0x81uy;
    0xa5uy; 0x38uy; 0x32uy; 0x7auy; 0xf9uy; 0x27uy; 0xdauy; 0x3euy
    ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* Call the hash function *)
  Hash.init state;
  Hash.update_last state plaintext (FStar.Int.Cast.uint32_to_uint64 plaintext_len);
  Hash.finish state output;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 2a") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()


val test_2b: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_2b () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 0ul in
  let plaintext = FStar.Buffer.createL [] in

  let expected = FStar.Buffer.createL [
    0xcfuy; 0x83uy; 0xe1uy; 0x35uy; 0x7euy; 0xefuy; 0xb8uy; 0xbduy;
    0xf1uy; 0x54uy; 0x28uy; 0x50uy; 0xd6uy; 0x6duy; 0x80uy; 0x07uy;
    0xd6uy; 0x20uy; 0xe4uy; 0x05uy; 0x0buy; 0x57uy; 0x15uy; 0xdcuy;
    0x83uy; 0xf4uy; 0xa9uy; 0x21uy; 0xd3uy; 0x6cuy; 0xe9uy; 0xceuy;
    0x47uy; 0xd0uy; 0xd1uy; 0x3cuy; 0x5duy; 0x85uy; 0xf2uy; 0xb0uy;
    0xffuy; 0x83uy; 0x18uy; 0xd2uy; 0x87uy; 0x7euy; 0xecuy; 0x2fuy;
    0x63uy; 0xb9uy; 0x31uy; 0xbduy; 0x47uy; 0x41uy; 0x7auy; 0x81uy;
    0xa5uy; 0x38uy; 0x32uy; 0x7auy; 0xf9uy; 0x27uy; 0xdauy; 0x3euy
    ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* Call the hash function *)
  Hash.hash output plaintext plaintext_len;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 2b") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()



val test_3a: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_3a () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 56ul in
  let plaintext = FStar.Buffer.createL [
    0x61uy; 0x62uy; 0x63uy; 0x64uy; 0x62uy; 0x63uy; 0x64uy; 0x65uy;
    0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy;
    0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy;
    0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x68uy; 0x69uy; 0x6auy; 0x6buy;
    0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy;
    0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy;
    0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy
  ] in

  let expected = FStar.Buffer.createL [
  0x20uy; 0x4auy; 0x8fuy; 0xc6uy; 0xdduy; 0xa8uy; 0x2fuy; 0x0auy;
  0x0cuy; 0xeduy; 0x7buy; 0xebuy; 0x8euy; 0x08uy; 0xa4uy; 0x16uy;
  0x57uy; 0xc1uy; 0x6euy; 0xf4uy; 0x68uy; 0xb2uy; 0x28uy; 0xa8uy;
  0x27uy; 0x9buy; 0xe3uy; 0x31uy; 0xa7uy; 0x03uy; 0xc3uy; 0x35uy;
  0x96uy; 0xfduy; 0x15uy; 0xc1uy; 0x3buy; 0x1buy; 0x07uy; 0xf9uy;
  0xaauy; 0x1duy; 0x3buy; 0xeauy; 0x57uy; 0x78uy; 0x9cuy; 0xa0uy;
  0x31uy; 0xaduy; 0x85uy; 0xc7uy; 0xa7uy; 0x1duy; 0xd7uy; 0x03uy;
  0x54uy; 0xecuy; 0x63uy; 0x12uy; 0x38uy; 0xcauy; 0x34uy; 0x45uy

  ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* Call the hash function *)
  Hash.init state;
  Hash.update_last state plaintext (FStar.Int.Cast.uint32_to_uint64 plaintext_len);
  Hash.finish state output;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 3a") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()


val test_3b: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_3b () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 56ul in
  let plaintext = FStar.Buffer.createL [
    0x61uy; 0x62uy; 0x63uy; 0x64uy; 0x62uy; 0x63uy; 0x64uy; 0x65uy;
    0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy;
    0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy;
    0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x68uy; 0x69uy; 0x6auy; 0x6buy;
    0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy;
    0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy;
    0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy
  ] in

  let expected = FStar.Buffer.createL [
    0x20uy; 0x4auy; 0x8fuy; 0xc6uy; 0xdduy; 0xa8uy; 0x2fuy; 0x0auy;
    0x0cuy; 0xeduy; 0x7buy; 0xebuy; 0x8euy; 0x08uy; 0xa4uy; 0x16uy;
    0x57uy; 0xc1uy; 0x6euy; 0xf4uy; 0x68uy; 0xb2uy; 0x28uy; 0xa8uy;
    0x27uy; 0x9buy; 0xe3uy; 0x31uy; 0xa7uy; 0x03uy; 0xc3uy; 0x35uy;
    0x96uy; 0xfduy; 0x15uy; 0xc1uy; 0x3buy; 0x1buy; 0x07uy; 0xf9uy;
    0xaauy; 0x1duy; 0x3buy; 0xeauy; 0x57uy; 0x78uy; 0x9cuy; 0xa0uy;
    0x31uy; 0xaduy; 0x85uy; 0xc7uy; 0xa7uy; 0x1duy; 0xd7uy; 0x03uy;
    0x54uy; 0xecuy; 0x63uy; 0x12uy; 0x38uy; 0xcauy; 0x34uy; 0x45uy
  ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* Call the hash function *)
  Hash.hash output plaintext plaintext_len;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 3b") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()



val test_4a: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_4a () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 112ul in
  let plaintext = FStar.Buffer.createL [
      0x61uy; 0x62uy; 0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy;
      0x62uy; 0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy;
      0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy;
      0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy;
      0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy;
      0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy;
      0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy;
      0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy;
      0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy; 0x70uy;
      0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy;
      0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy; 0x72uy;
      0x6cuy; 0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy; 0x72uy; 0x73uy;
      0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy; 0x72uy; 0x73uy; 0x74uy;
      0x6euy; 0x6fuy; 0x70uy; 0x71uy; 0x72uy; 0x73uy; 0x74uy; 0x75uy
    ] in

  let expected = FStar.Buffer.createL [
    0x8euy; 0x95uy; 0x9buy; 0x75uy; 0xdauy; 0xe3uy; 0x13uy; 0xdauy;
    0x8cuy; 0xf4uy; 0xf7uy; 0x28uy; 0x14uy; 0xfcuy; 0x14uy; 0x3fuy;
    0x8fuy; 0x77uy; 0x79uy; 0xc6uy; 0xebuy; 0x9fuy; 0x7fuy; 0xa1uy;
    0x72uy; 0x99uy; 0xaeuy; 0xaduy; 0xb6uy; 0x88uy; 0x90uy; 0x18uy;
    0x50uy; 0x1duy; 0x28uy; 0x9euy; 0x49uy; 0x00uy; 0xf7uy; 0xe4uy;
    0x33uy; 0x1buy; 0x99uy; 0xdeuy; 0xc4uy; 0xb5uy; 0x43uy; 0x3auy;
    0xc7uy; 0xd3uy; 0x29uy; 0xeeuy; 0xb6uy; 0xdduy; 0x26uy; 0x54uy;
    0x5euy; 0x96uy; 0xe5uy; 0x5buy; 0x87uy; 0x4buy; 0xe9uy; 0x09uy
    ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* Call the hash function *)
  Hash.init state;
  Hash.update_last state plaintext (FStar.Int.Cast.uint32_to_uint64 plaintext_len);
  Hash.finish state output;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 4a") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()


val test_4b: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_4b () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 112ul in
  let plaintext = FStar.Buffer.createL [
      0x61uy; 0x62uy; 0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy;
      0x62uy; 0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy;
      0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy;
      0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy;
      0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy;
      0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy;
      0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy;
      0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy;
      0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy; 0x70uy;
      0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy;
      0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy; 0x72uy;
      0x6cuy; 0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy; 0x72uy; 0x73uy;
      0x6duy; 0x6euy; 0x6fuy; 0x70uy; 0x71uy; 0x72uy; 0x73uy; 0x74uy;
      0x6euy; 0x6fuy; 0x70uy; 0x71uy; 0x72uy; 0x73uy; 0x74uy; 0x75uy
    ] in

  let expected = FStar.Buffer.createL [
    0x8euy; 0x95uy; 0x9buy; 0x75uy; 0xdauy; 0xe3uy; 0x13uy; 0xdauy;
    0x8cuy; 0xf4uy; 0xf7uy; 0x28uy; 0x14uy; 0xfcuy; 0x14uy; 0x3fuy;
    0x8fuy; 0x77uy; 0x79uy; 0xc6uy; 0xebuy; 0x9fuy; 0x7fuy; 0xa1uy;
    0x72uy; 0x99uy; 0xaeuy; 0xaduy; 0xb6uy; 0x88uy; 0x90uy; 0x18uy;
    0x50uy; 0x1duy; 0x28uy; 0x9euy; 0x49uy; 0x00uy; 0xf7uy; 0xe4uy;
    0x33uy; 0x1buy; 0x99uy; 0xdeuy; 0xc4uy; 0xb5uy; 0x43uy; 0x3auy;
    0xc7uy; 0xd3uy; 0x29uy; 0xeeuy; 0xb6uy; 0xdduy; 0x26uy; 0x54uy;
    0x5euy; 0x96uy; 0xe5uy; 0x5buy; 0x87uy; 0x4buy; 0xe9uy; 0x09uy
    ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* Call the hash function *)
  Hash.hash output plaintext plaintext_len;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 4b") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()



val test_5: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_5 () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 1000000ul in
  let plaintext = FStar.Buffer.create 0x61uy plaintext_len in

  let expected = FStar.Buffer.createL [
    0xe7uy; 0x18uy; 0x48uy; 0x3duy; 0x0cuy; 0xe7uy; 0x69uy; 0x64uy;
    0x4euy; 0x2euy; 0x42uy; 0xc7uy; 0xbcuy; 0x15uy; 0xb4uy; 0x63uy;
    0x8euy; 0x1fuy; 0x98uy; 0xb1uy; 0x3buy; 0x20uy; 0x44uy; 0x28uy;
    0x56uy; 0x32uy; 0xa8uy; 0x03uy; 0xafuy; 0xa9uy; 0x73uy; 0xebuy;
    0xdeuy; 0x0fuy; 0xf2uy; 0x44uy; 0x87uy; 0x7euy; 0xa6uy; 0x0auy;
    0x4cuy; 0xb0uy; 0x43uy; 0x2cuy; 0xe5uy; 0x77uy; 0xc3uy; 0x1buy;
    0xebuy; 0x00uy; 0x9cuy; 0x5cuy; 0x2cuy; 0x49uy; 0xaauy; 0x2euy;
    0x4euy; 0xaduy; 0xb2uy; 0x17uy; 0xaduy; 0x8cuy; 0xc0uy; 0x9buy
    ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* Call the hash function *)
  Hash.hash output plaintext plaintext_len;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 5") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()



val test_6_loop:
  state:FStar.Buffer.buffer FStar.UInt64.t ->
  plaintext:FStar.Buffer.buffer FStar.UInt8.t ->
  ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_6_loop state plaintext =
  let inv (h1: HyperStack.mem) (i: nat) : Type0 =
    live h1 state /\ i <= v 8388607ul
  in
  let f' (t:FStar.UInt32.t) :
    Stack unit
      (requires (fun h -> True))
      (ensures (fun h_1 _ h_2 -> True))
    =
    Hash.update state plaintext
  in
  C.Loops.for 0ul 8388607ul inv f'


val test_6: unit -> ST unit
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let test_6 () =

  (* Push a new memory frame *)
  (**) push_frame();

  let output_len = 64ul in
  let output = FStar.Buffer.create 0uy output_len in

  let plaintext_len = 128ul in
  let plaintext = FStar.Buffer.createL [
      0x61uy; 0x62uy; 0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy;
      0x62uy; 0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy;
      0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy;
      0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy;
      0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy;
      0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy;
      0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy;
      0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy;
      0x61uy; 0x62uy; 0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy;
      0x62uy; 0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy;
      0x63uy; 0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy;
      0x64uy; 0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy;
      0x65uy; 0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy;
      0x66uy; 0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy;
      0x67uy; 0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy;
      0x68uy; 0x69uy; 0x6auy; 0x6buy; 0x6cuy; 0x6duy; 0x6euy; 0x6fuy
  ] in

  let expected = FStar.Buffer.createL [
    0xb4uy; 0x7cuy; 0x93uy; 0x34uy; 0x21uy; 0xeauy; 0x2duy; 0xb1uy;
    0x49uy; 0xaduy; 0x6euy; 0x10uy; 0xfcuy; 0xe6uy; 0xc7uy; 0xf9uy;
    0x3duy; 0x07uy; 0x52uy; 0x38uy; 0x01uy; 0x80uy; 0xffuy; 0xd7uy;
    0xf4uy; 0x62uy; 0x9auy; 0x71uy; 0x21uy; 0x34uy; 0x83uy; 0x1duy;
    0x77uy; 0xbeuy; 0x60uy; 0x91uy; 0xb8uy; 0x19uy; 0xeduy; 0x35uy;
    0x2cuy; 0x29uy; 0x67uy; 0xa2uy; 0xe2uy; 0xd4uy; 0xfauy; 0x50uy;
    0x50uy; 0x72uy; 0x3cuy; 0x96uy; 0x30uy; 0x69uy; 0x1fuy; 0x1auy;
    0x05uy; 0xa7uy; 0x28uy; 0x1duy; 0xbeuy; 0x6cuy; 0x10uy; 0x86uy
    ] in

  (* Allocate memory for state *)
  let state = FStar.Buffer.create 0uL Hash.size_state in

  (* initialize the hash state *)
  Hash.init state;

  test_6_loop state plaintext;

  let rem_len = UInt32.rem (128ul *%^ 8388607ul) Hash.size_block in
  Hash.update_last state plaintext (FStar.Int.Cast.uint32_to_uint64 plaintext_len);
  Hash.finish state output;

  (* Display the result *)
  TestLib.compare_and_print (C.string_of_literal "Test 6") expected output 64ul;

  (* Pop the memory frame *)
  (**) pop_frame()



val main: unit -> ST FStar.Int32.t
  (requires (fun h -> True))
  (ensures  (fun h0 r h1 -> True))
let main () =

  (* Run test vector 1 *)
  test_1a ();
  test_1b ();

  (* Run test vector 2 *)
  test_2a ();
  test_2b ();

  (* Run test vector 3 *)
  test_3a ();
  test_3b ();

  (* Run test vector 4 *)
  test_4a ();
  test_4b ();

  (* Run test vector 5 *)
  test_5 ();

  (* Run test vector 6 *)
  test_6();

  (* Exit the program *)
  C.exit_success
