---
layout: blog
title: 2022-09-25 Leetcode Weekly Contest 313
category: [Leetcode]
excerpt: LinkedIn Learning
---


| Infomration             | Value                                                                                                                                                                                                  |
|:------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Contest Link            | [LeetCode Weekly Contest 312](https://leetcode.com/contest/weekly-contest-312/) |
| Date                    | 2022-09-25                                                                                                                                                                        | 
| Why Taking this course? | Data Structure and Algorithm is the foundation for software engineer                                                                                                                   |
| Summary                 | AC [Q1](https://leetcode.com/contest/weekly-contest-312/problems/sort-the-people/)       [Q2](https://leetcode.com/contest/weekly-contest-312/problems/longest-subarray-with-maximum-bitwise-and/)      [Q3](https://leetcode.com/contest/weekly-contest-312/problems/find-all-good-indices/)        ; No idea [Q4](https://leetcode.com/contest/weekly-contest-312/problems/number-of-good-paths/)        WA twice   for Q3    |
| Ranking | <img src="{{site.baseurl}}/images/posts/leetcode/2022-09-25/leetcode_20220925_ranking.png" width = '350' >

This week I started my LeetCode competition after pausing this 'weekly activity' for roughly half years. This is mainly to sharpen my algorithm and data structure skill as the foundation as a software engineer. The first three questions are quite straight forward and are completed within the first 27 mins (althought the [Q3](https://leetcode.com/contest/weekly-contest-312/problems/find-all-good-indices/)     was a little big confusing to me, which I will explain later ). I have no idea for the 4-th question  [Q4](https://leetcode.com/contest/weekly-contest-312/problems/number-of-good-paths/)   during the contest, so I will focus on this question in this post. 

**Question 2420. Find All Good Indices**
```
You are given a 0-indexed integer array nums of size n and a positive integer k.

We call an index i in the range k <= i < n - k good if the following conditions are satisfied:

The k elements that are just before the index i are in non-increasing order.
The k elements that are just after the index i are in non-decreasing order.
Return an array of all good indices sorted in increasing order.
```

This question is straight-forward in term that it's a DP problem that's asking us to calculate the length of consecutive non-increase (non-decreasing) substring before a specific element in an array, using which we can later using the k-threshold to get the number of element satisyfing the requirement of last-K non-increasing (non-decreasing) substring. The reason why I said it's confusive at the summery is the indices. The question ask K element before the index i, which means the element at the index `i` should be excluded from the `k` elements.  Below is my code after fixing the confusive part. 


```python
class Solution:
    def goodIndices(self, nums: List[int], k: int) -> List[int]:
        
        dp_left = [0] * len(nums)
        dp_right = [0] * len(nums)
        n = len(nums)
        
        # dp_left is the number of non-increasing element before index i (inclusive)
        dp_left[0] = 1
        for i in range(1, n):
            if nums[i-1] >= nums[i]:
                dp_left[i] = dp_left[i-1] + 1
            else:
                dp_left[i] = 1

        # dp_right is the number of non-decreasing element after index i (inclusive)
        dp_right[n-1] = 1
        for i in range(n-2, -1, -1):
            if nums[i+1] >= nums[i]:
                dp_right[i] = dp_right[i+1] + 1
            else:
                dp_right[i] = 1
        
        res = []
        for i in range(k, n-k):
            # if the left element (i-1) satisfy the >= k criteria and right element (i+1) satisfy the >= k criteria, update the result
            if dp_left[i-1] >= k and dp_right[i+1] >= k:
                res.append(i)
        return res
```


**Question 2421. Number of Good Paths**

```
There is a tree (i.e. a connected, undirected graph with no cycles) consisting of n nodes numbered from 0 to n - 1 and exactly n - 1 edges.

You are given a 0-indexed integer array vals of length n where vals[i] denotes the value of the ith node. You are also given a 2D integer array edges where edges[i] = [ai, bi] denotes that there exists an undirected edge connecting nodes ai and bi.

A good path is a simple path that satisfies the following conditions:

The starting node and the ending node have the same value.
All nodes between the starting node and the ending node have values less than or equal to the starting node (i.e. the starting node's value should be the maximum value along the path).
Return the number of distinct good paths.

Note that a path and its reverse are counted as the same path. For example, 0 -> 1 is considered to be the same as 1 -> 0. A single node is also considered as a valid path.
```

This question is very good and it's a good use of [UnionFind](https://leetcode.com/explore/learn/card/graph/618/disjoint-set/) knowledge. I referred to this [Youtube Video](https://www.youtube.com/watch?v=_uVYiM7LmSk&t=1264s) which is super clear.

**The Learnt Method for Q2421**

The high-level (intuitive idea) for answer this question is: we should first the node with value equal to the largest value in the tree, let's say we found totally N such nodes. Then the total number of path should be C(N, 2) = N * (N-1) / 2, because the path connecting each pair of nodes should work, because both condisions (1. end with same values 2. all other values on the path smaller than the value in the end). We then remove this N nodes, which split the trees into pieces. We then recursively work on each of these pieces with the same procedure until the tree is broken into individual nodes.

However, despite the intuition behind this method, the implementation is super inefficient for this approach because there is no way to effeciently recusively remove node while still can search for the largest nodes in the tree pieces. Therefore the idea for the solution is in the reverse order, i.e. we start from individual nodes in the tree as the baseline, then we try to union the nodes with value smaller than a threashold, and keep increasing this threshold untill all the nodes are connected into the very original tree.  This approach is supported by the [UnionFind](https://leetcode.com/explore/learn/card/graph/618/disjoint-set/). 

* Step-1: each individual node itself satisy the requirement, `res += N`
* Step-2: iterate through all values (small to large), for all nodes with the value, "activate" them (i.e. add into `visited` set) and try add the neighbors into the `UnionFind` **if** the neighbor has been activated (i.e. the neighbor is smaller than or equal to the value, it's importance cuz otherwise the larger inactivated value will split the smaller values)
* Step-3: for each joint (i.e. connected) nodes, `res += n * (n-1) / 2`, where `n` is the number of occurance for value.

Here is my code for this question

```python

class UnionFind:
    
    def __init__(self, N):
        self.parent_node = {i:i for i in range(N)}

    def op_find(self, k):
        if self.parent_node[k] == k:
            return k
        # here is a minor optimization that can reduce the complexity from O(n) to O(1) for frequent finding.
        self.parent_node[k] = self.op_find(self.parent_node[k])
        return self.parent_node[k]

    def op_union(self, a, b):
        x = self.op_find(a)
        y = self.op_find(b)
        self.parent_node[x] = y
    
    
class Solution:
    def numberOfGoodPaths(self, vals: List[int], edges: List[List[int]]) -> int:
        
        
        # result
        N = len(vals)
        res = 0
        # each node itself satisfy the condition, so add N to result.
        res += N
        
        
        uf = uf_ds(N)
        
        #map value to index
        map_val_to_idx = collections.defaultdict(list)
        for i, v in enumerate(vals):
            map_val_to_idx[v].append(i)
        
        #map index to neighbor index
        map_idx_to_neighbor_idx = collections.defaultdict(list)
        for i, j in edges:
            map_idx_to_neighbor_idx[i].append(j)
            map_idx_to_neighbor_idx[j].append(i)
        
        # starting from the small value to large value, because small value can't be splitted by large values, we have to start from smaller one.
        val_sorted = sorted(list(map_val_to_idx.keys()), reverse = False)
        
        # the 'visited' node let us know the smaller value we have seen so far, so that we can connect to them.
        visited = set()
        for val in val_sorted:
            idxs = map_val_to_idx[val]
            for idx in idxs:
                visited.add(idx)
            for idx in idxs:
                for neighbor in map_idx_to_neighbor_idx[idx]:
                    if neighbor in visited:
                        uf.op_union(idx, neighbor)
            map_parent_to_idx = collections.defaultdict(list)
            for idx in idxs:
                map_parent_to_idx[uf.op_find(idx)].append(idx)
            for parent in map_parent_to_idx:
                l = len(map_parent_to_idx[parent])
                if l > 1:
                    res += l * (l-1) // 2
        
        return res
```

