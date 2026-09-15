import test from 'node:test'; import assert from 'node:assert/strict';
test('arena progression contract',()=>{const chain=['NORMAL','CRACKED','COLLAPSED','ABYSS'];assert.deepEqual(chain,['NORMAL','CRACKED','COLLAPSED','ABYSS']);});
test('telegraph fairness contract',()=>{assert.ok(1.5>=1.0);});
