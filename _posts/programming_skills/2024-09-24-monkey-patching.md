---
layout: blog
title: 2024-09-24 Achieving Monkey Patching with Python's Context Manager (`with` Statement)
category: [Software Engineering, Python]
excerpt: Software Engineering
---

# Achieving Monkey Patching with Python's Context Manager (`with` Statement)

## Motivation

Today, while exploring the source code of [VCR.py](https://github.com/kevin1024/vcrpy), I discovered an interesting method of applying monkey patching using a context manager. This approach simplifies code usage and enhances readability, which is particularly helpful when temporarily altering the behavior of a module.

For example, we aim to achieve something like this:
```python
with context_manager_that_can_patch_module(foo=new_foo):
    some_module.foo()  # the behavior of foo is changed to new_foo
# outside the context, behavior is restored.
```


## Concept: What is Monkey patching

Monkey patching is a technique in Python where you dynamically replace a function in a module with a new one. This modification is temporary when using a context manager, making it convenient to apply patches and revert changes automatically.

For instance, if we import a module and modify one of its functions:
```python 
import module_original
module_original.foo = new_foo  # foo is now replaced by new_foo
```
The behavior of `module_original.foo()` will now point to `new_foo()`. Once you finish the patching, it's often important to restore the original function. This is where context managers shine, as they handle this restoration for us automatically.



## Demo code
1. `module_original.py`
```python
def foo():
    print("Original method")
```

2. `module_patcher.py`
```python
class ModuleFunctionPatcher:
    def __init__(self, foo):
        self.foo = foo

    def __enter__(self):
        import module_original
        self.original_foo = module_original.foo
        module_original.foo = self.foo
        
```

3. `demo.py`
```python
import module_original
from module_patcher import ModuleFunctionPatcher

def new_foo():
    print("New foo")

module_original.foo() # Original foo

with ModuleFunctionPatcher(new_foo): # this is how the monkey patching is applied.
    module_original.foo()  # This will call new_foo instead of the original foo

module_original.foo() # Original foo
```

Output:
```
Original foo
New foo
Original foo
```

## A better way using `mock.patch.object`

The above implementation is not perfect.
1. The `ModuleFunctionPatcher` class is not general purpose. It is designed to patch a specific function in a specific module.
2. It is not flexible. If we want to patch a method of a class, we have to create a new patcher.

A better way is to use `mock.patch.object` which is more general purpose.


2. `module_patcher.py`
```python
class ModuleFunctionMockPatcher:
    def __init__(self, foo):
        self.foo = foo
        self.patcher = None

    def __enter__(self):
        self.patcher = mock.patch.object(module_original, 'foo', self.foo)
        self.patcher.start() # we need to call start here and later stop it in __exit__

    def __exit__(self, exc_type, exc_value, traceback):
        if self.patcher:
            self.patcher.stop()
```


## Fun Thing: Why is it called "Monkey Patching"
When I firstly time heard this name "monkey patching", I was like, why is it called "monkey". After some researching I found that word "monkey" is often associated with playful, sometimes messy, or unorthodox behavior. Since such kind of run-time patching is not really recommended as it leaded inconsistent behavior with the source code, people named it monkey patching.

