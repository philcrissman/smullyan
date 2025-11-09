# Step-by-Step Conversion of Z Combinator to SKI

## Starting Point

```
Z = λf. (λx. f (λv. x x v)) (λx. f (λv. x x v))
```

## Strategy

Since both parts are identical, let's convert:
```
W = λx. f (λv. x x v)
```

Then:
```
Z = λf. W W
```

## Step 1: Convert λv. x x v

This is the innermost lambda. The body is `x x v`, which is `(x x) v`.

Using the rule: `T[λv. M N] = S T[λv.M] T[λv.N]`

```
T[λv. (x x) v] = S T[λv. x x] T[λv. v]
```

### Part A: T[λv. x x]
`v` doesn't appear in `x x`, so:
```
T[λv. x x] = K (x x)
```

### Part B: T[λv. v]
```
T[λv. v] = I
```

### Result:
```
T[λv. x x v] = S (K (x x)) I
```

## Step 2: Convert λx. f (λv. x x v)

Now we need to abstract over `x`. The body is `f (λv. x x v)`.

We've converted the inner lambda to `S (K (x x)) I`, but we still have `x x` in there!

Let me denote `S (K (x x)) I` as `E` for clarity, where `E` depends on `x`.

The body is `f E` where:
- `f` doesn't contain `x`
- `E = S (K (x x)) I` contains `x`

Using the S rule:
```
T[λx. f E] = S T[λx. f] T[λx. E]
```

### Part A: T[λx. f]
```
T[λx. f] = K f
```

### Part B: T[λx. S (K (x x)) I]

This is tricky! We need to abstract over `x` in the expression `S (K (x x)) I`.

The structure is: `S (K (x x)) I`

This is an application of `S (K (x x))` to `I`.

Let's break it down:
```
T[λx. S (K (x x)) I] = T[λx. (S (K (x x))) I]
```

Using the S rule (since x appears in the left part):
```
= S T[λx. S (K (x x))] T[λx. I]
```

#### T[λx. I]
`x` doesn't appear in `I`:
```
T[λx. I] = K I
```

#### T[λx. S (K (x x))]
This is `S` applied to `K (x x)`. Since `x` appears in the right part only:
```
T[λx. S (K (x x))] = T[λx. (S) (K (x x))]
                   = S T[λx. S] T[λx. K (x x)]
                   = S (K S) T[λx. K (x x)]
```

Now for `T[λx. K (x x)]`:
```
T[λx. K (x x)] = T[λx. (K) (x x)]
                = S T[λx. K] T[λx. x x]
                = S (K K) T[λx. x x]
```

And `T[λx. x x]`:
```
T[λx. x x] = T[λx. (x) (x)]
            = S T[λx. x] T[λx. x]
            = S I I
```

### Putting it together:

```
T[λx. x x] = S I I
T[λx. K (x x)] = S (K K) (S I I)
T[λx. S (K (x x))] = S (K S) (S (K K) (S I I))
T[λx. S (K (x x)) I] = S (S (K S) (S (K K) (S I I))) (K I)
```

So:
```
T[λx. E] = S (S (K S) (S (K K) (S I I))) (K I)
```

### Result of Step 2:

```
T[λx. f (λv. x x v)] = S (K f) (S (S (K S) (S (K K) (S I I))) (K I))
```

Let me call this `W'` (the SKI version of W).

## Step 3: Convert λf. W W

Now we need:
```
T[λf. W W] = T[λf. (W) (W)]
```

Using the S rule:
```
= S T[λf. W] T[λf. W]
```

Both are the same:
```
T[λf. W] = T[λf. λx. f (λv. x x v)]
```

We need to convert `λx. f (λv. x x v)` where `f` is now a variable (not free).

Actually, this gets complex because we need to substitute our W' but with f as a variable...

Let me denote:
```
W = λx. f (λv. x x v)
```

We already know:
```
W' = S (K f) (S (S (K S) (S (K K) (S I I))) (K I))
```

But when f is a variable (not free), we need:
```
T[λf. W] = ?
```

Hmm, this is getting very complex. Let me try a different approach...

Actually, I think we should TEST whether my calculation so far is correct!

Let's test: `W' = S (K f) (S (S (K S) (S (K K) (S I I))) (K I))`

This should equal `λx. f (λv. x x v)` when f is given.
