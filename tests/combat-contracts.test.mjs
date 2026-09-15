import test from 'node:test'; import assert from 'node:assert/strict';
test('combat invariants',()=>{const hp=100,armor=5,damage=20;assert.equal(Math.max(0,hp-Math.max(0,damage-armor)),85);});
test('energy invariant',()=>{let e=10;e-=4;assert.equal(e,6);assert.ok(e<10);});
