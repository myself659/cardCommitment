pragma circom 2.0.0;

// include "../../node_modules/circomlib/circuits/comparators.circom";
include "../../node_modules/circomlib/circuits/mimcsponge.circom";

template cardHash() {

    // card number 0-51
    // 0-12:  piques ♠
    // 13-25: cœurs  ♥
    // 26-38: trèfles ♣
    // 39-51: carreaux ♦
    signal input num;
    signal input password;

    // Output
    signal output HashCommit;
    // MiMCSponge as hash function
    component mimc = MiMCSponge(2, 220, 1);
    mimc.ins[0] <== num;
    mimc.ins[1] <== password;
    mimc.k <== 0;

    HashCommit <== mimc.outs[0];
}

component main  = cardHash();