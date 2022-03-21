#!/bin/bash

circom circuit.circom --r1cs --wasm --sym --c

cp input.json circuit_js/input.json

cd circuit_js

node generate_witness.js circuit.wasm input.json witness.wtns
cp  witness.wtns  ../witness.wtns

cd  ..

snarkjs powersoftau new bn128 13 pot13_0000.ptau -v
snarkjs powersoftau contribute pot13_0000.ptau pot13_0001.ptau --name="First contribution" -v -e="some random text"\n
snarkjs powersoftau prepare phase2 pot13_0001.ptau pot13_final.ptau -v

snarkjs groth16 setup circuit.r1cs pot13_final.ptau circuit_0000.zkey
snarkjs zkey contribute circuit_0000.zkey circuit_0001.zkey --name="1st Contributor Name" -v -e="some random text"\n

snarkjs zkey export verificationkey circuit_0001.zkey verification_key.json

snarkjs groth16 prove circuit_0001.zkey witness.wtns proof.json public.json

snarkjs groth16 verify verification_key.json public.json proof.json

snarkjs zkey export solidityverifier circuit_0001.zkey verifier.sol