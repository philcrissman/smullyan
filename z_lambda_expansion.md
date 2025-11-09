# Lambda Calculus Expansion of Z = BU(CBQ)

## Combinator Definitions in Lambda Calculus

```
B = λx.λy.λz. x (y z)
C = λx.λy.λz. x z y
U = λx.λy. y (x x y)
Q = λx.λy.λz. y (x z)   [Queer bird]
```

## Step-by-Step Expansion

### Step 1: Expand C B Q

```
C B Q
= (λx.λy.λz. x z y) B Q
= λy.λz. B z y
= λy.λz. B z y
```

Now substitute B = λx.λy.λz. x (y z):
```
= λy.λz. (λx.λy'.λz'. x (y' z')) z y
= λy.λz. (λy'.λz'. z (y' z')) y
= λy.λz. (λz'. z (y z'))
= λy.λz. λz'. z (y z')
```

Hmm, this is getting complex. Let me simplify by doing beta reduction:
```
C B Q = λy.λz. z (y z)   [This is NOT what I expected!]
```

Wait, let me check this. C x y z = x z y, so:
```
C B Q f = B f Q
```

And B f Q g = f (Q g).

### Step 2: Expand B U (C B Q)

```
B U (C B Q)
= λz. U ((C B Q) z)
= λz. U (B z Q)    [since C B Q f = B f Q]
```

Now U (B z Q):
```
U = λx.λy. y (x x y)
U (B z Q) = λy. y ((B z Q) (B z Q) y)
```

So:
```
B U (C B Q) = λz. λy. y ((B z Q) (B z Q) y)
```

This means Z f = λy. y ((B f Q) (B f Q) y)

### Step 3: Expand (B f Q) (B f Q) y

```
B f Q (B f Q) y = f (Q (B f Q)) y
                = f (Q (B f Q) y)
```

Now Q (B f Q) y:
```
Q = λx.λy.λz. y (x z)
Q (B f Q) y = λz. y ((B f Q) z)
            = λz. y (f (Q z))
```

So:
```
Z f y = y (f (λz. y (f (Q z))))
```

## The Problem!

In Z f y = y (f (λz. y (f (Q z)))), we're calling `y` as a function: `y (...)`.

But when using Z for factorial, `y` is a NUMBER (like 5), not a function!

This confirms the formula Z = BU(CBQ) with Q as the Queer bird DOES NOT WORK.

## Direct Z for Comparison

```
Z = λf. (λx. f (λv. x x v)) (λx. f (λv. x x v))
Z f = f (λv. (λx. f (λv. x x v)) (λx. f (λv. x x v)) v)
    = f (λv. Z f v)
```

This is correct! When f receives `λv. Z f v`, it's a function that f can call.

## Conclusion

The formula Z = BU(CBQ) where Q is the Queer bird (Q x y z = y (x z)) produces:
```
Z f y = y (f (...))
```

This tries to call `y` as a function, which fails when `y` is a number.

**Therefore**: Either the formula is wrong, OR Q means something different than the Queer bird!
