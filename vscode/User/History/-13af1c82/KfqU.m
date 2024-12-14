m_ary = 4;
numSymbols = 10;
numCarriers = 96;
numBits = numSymbols * numCarriers * log2(m_ary);
bits = randi([0,1], 1, numBits);

pilotSequence = [0,0,0,0,1,1,1,0,1,1,1,1,0,0,1,0,1,1,0,0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,1,0,0,1,1,0,0,0,1,0,1,1,1,0,1,0,1,1,0,1,1,0,0,0,0,0,1,1,0,0,1,1,0,1,0,1,0,0,1,1,1,0,0,1,1,1,1,0,1,1,0,1,0,0,0,0,1,0,1,0,1,0,1,1,1,1,1,0,1,0,0,1,0,1,0,0,0,1,1,0,1,1,1,0,0,0,1,1,1,1,1,1,1];
constellation = [0, pi/2, pi, 3*pi/2];



a = tx.modulatorDnPSK(bits, constellation, numSymbols, numCarriers, pilotSequence);
b = rx.demodulatorDnPSK(a, constellation, numSymbols, numCarriers);

a(1:10)
b(1:10)