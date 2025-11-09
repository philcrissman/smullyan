# Z Combinator Derivation Investigation

## Summary

We investigated whether the Z combinator can be expressed as `Z = BU(CBQ)` using standard combinators, where Q is the Queer bird.

**Conclusion**: The formula `Z = BU(CBQ)` **does NOT work** when Q is defined as the Queer bird `Q x y z = y (x z)`.

## The Problem

### Working Direct Implementation
```
Z = λf. (λx. f (λv. x x v)) (λx. f (λv. x x v))
Z f = f (λv. Z f v)
```

This works because when `f` receives `λv. Z f v`, it gets a function that takes a number and recursively computes the result.

### Derived Formula with Queer Bird
```
Q = λx.λy.λz. y (x z)   [Queer bird]
Z = BU(CBQ)
```

Through lambda calculus reduction, this produces:
```
Z f y = y (f (λz. y (f (Q z))))
```

**The Issue**: This tries to call `y` as a function: `y (...)`.

When using Z for factorial with `factorial.(5)`, `y` is the number 5, not a function. Calling `5 (...)` fails with `TypeError: Proc can't be coerced into Integer`.

## Detailed Reduction

See `z_lambda_expansion.md` for the complete step-by-step lambda calculus reduction proving this.

## Experimental Evidence

1. **Q and U implementations are correct**: Both pass their definitional tests
2. **Direct Z works**: Successfully computes factorial, fibonacci, etc.
3. **Derived Z = BU(CBQ) fails**: Always fails with type error when trying to use the result

See test scripts:
- `z_reduction.rb` - Initial investigation
- `z_deep_trace.rb` - Deep execution trace showing the failure point
- `z_analysis.rb` - Analysis of why the extra layer exists

## Possible Explanations

1. **Q is not the Queer bird in this context**
   The formula might use a different combinator also named Q

2. **The formula requires a different Q definition**
   Q might need to be an eta-expanded version of U or another variant

3. **The formula is for lazy evaluation**
   Despite Z being the "strict" combinator, the derivation formula might only work in lazy languages

4. **The Wikipedia formula may be incorrect or misinterpreted**
   The source needs verification

## Implications

This demonstrates an important principle in combinatory logic: **theoretical equivalence in lambda calculus doesn't always translate to practical equivalence in all evaluation strategies**. Even though Z is specifically designed for strict evaluation, its derivation in terms of other combinators may require those combinators to have special properties or definitions that differ from their standard forms.

## Next Steps

To resolve this, we would need to:
1. Find the original source defining what "Q" means in the Z combinator formula
2. Check if there's a standard definition of Q specifically for fixed-point combinators
3. Test whether the formula works in lazy evaluation languages (Haskell, etc.)
4. Look for alternative derivations of Z in terms of SKI or other base combinators
