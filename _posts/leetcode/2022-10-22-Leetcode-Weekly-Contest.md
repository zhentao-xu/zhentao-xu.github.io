---
layout: blog
title: 2022-10-22 Leetcode Weekly Contest 316
category: [Leetcode]
excerpt: Leetcode
---


| Infomration             | Value                                                                                                                                                                                                  |
|:------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Contest Link            | [LeetCode Weekly Contest 316](https://leetcode.com/contest/weekly-contest-316/) |
| Date                    | 2022-10-08   22                                                                                                                                                                   | 
| Why Taking this course? | Data Structure and Algorithm is the foundation for software engineer                                                                                                                   |
| Summary                 | AC [Q1](https://leetcode.com/contest/weekly-contest-316/problems/determine-if-two-events-have-conflict/)       [Q2](https://leetcode.com/contest/weekly-contest-316/problems/number-of-subarrays-with-gcd-equal-to-k/)    ;  [Q3](https://leetcode.com/contest/weekly-contest-316/problems/minimum-cost-to-make-array-equal/)      WA once      ; [Q4](https://leetcode.com/contest/weekly-contest-316/problems/minimum-number-of-operations-to-make-arrays-similar/)      |
| Ranking | <img src="{{site.baseurl}}/images/posts/leetcode/2022-10-22/leetcode_20221022_ranking.png" width = '350' >

### **Summary**

Last week I skipped the weekly contest once due to time conflict with a concert. So this week I am back. I feel this time the questions are a little bit harder than before, but luckily got ACs for all 4 questions. I personally really like the question [2448. Minimum Cost to Make Array Equal](https://leetcode.com/contest/weekly-contest-316/problems/minimum-cost-to-make-array-equal/) and [2449. Minimum Number of Operations to Make Arrays Similar](https://leetcode.com/contest/weekly-contest-316/problems/minimum-number-of-operations-to-make-arrays-similar/), But I will share my thoughts and learn how to get the answer faster next time.


##### **2447. Number of Subarrays With GCD Equal to K**
```

Given an integer array nums and an integer k, return the number of subarrays of nums where the greatest common divisor of the subarray's elements is k.

A subarray is a contiguous non-empty sequence of elements within an array.

The greatest common divisor of an array is the largest integer that evenly divides all the array elements.

 

Example 1:

Input: nums = [9,3,1,2,6,3], k = 3
Output: 4
Explanation: The subarrays of nums where 3 is the greatest common divisor of all the subarray's elements are:
- [9,3,1,2,6,3]
- [9,3,1,2,6,3]
- [9,3,1,2,6,3]
- [9,3,1,2,6,3]
Example 2:

Input: nums = [4], k = 7
Output: 0
Explanation: There are no subarrays of nums where 7 is the greatest common divisor of all the subarray's elements.
 

Constraints:

1 <= nums.length <= 1000
1 <= nums[i], k <= 109

```

I was stacked for a while during the contest for this question because I didn't realize the transitive property of GCD, i.e.
```
GCD([a,b,c,...]) = GCD([GCD(a,b), c,...])
```
Once this transitive property is clear, the solution to this question is straightforward by having O(n^2) solution with nested for-loop, where the outer loop is for starting index of subarray and the inner forloop is the ending index, and just like [cumulative sum,](https://leetcode.com/problems/running-sum-of-1d-array/) and dynamic programming, we can get the GCD for subarray nums[i:j] with complexity O(1) on average.





##### **2448. Minimum Cost to Make Array Equal**
```
You are given two 0-indexed arrays nums and cost consisting each of n positive integers.

You can do the following operation any number of times:

Increase or decrease any element of the array nums by 1.
The cost of doing one operation on the ith element is cost[i].

Return the minimum total cost such that all the elements of the array nums become equal.

 

Example 1:

Input: nums = [1,3,5,2], cost = [2,3,1,14]
Output: 8
Explanation: We can make all the elements equal to 2 in the following way:
- Increase the 0th element one time. The cost is 2.
- Decrease the 1st element one time. The cost is 3.
- Decrease the 2nd element three times. The cost is 1 + 1 + 1 = 3.
The total cost is 2 + 3 + 3 = 8.
It can be shown that we cannot make the array equal with a smaller cost.
Example 2:

Input: nums = [2,2,2,2,2], cost = [4,2,8,1,3]
Output: 0
Explanation: All the elements are already equal, so no operations are needed.
 

Constraints:

n == nums.length == cost.length
1 <= n <= 10^5
1 <= nums[i], cost[i] <= 10^6
```

This question just remind me of an interview question of finding the point that has minimal sum to all other points on a map (either 2D map or 1D map), the answer to that question is median, because the distance is a convex function of the location, and the derivative of distance is zero (i.e. global minimal) when the location is at median. 

The difference in this question is that the cost function is not the same for each points, but I think the idea is still the same. Let's say the function `d(x)` is the distance function where `x` is the location of the equal number (i.e. all number should later be updated to this number), then the total cost will be `d(x) = sum_{i \in range(nums)} (|nums[i] - x| * cost[i])`, therefore the derivative `d(x)/dx = sum(sign(nums[i] - x) * cost[i])`.

With the derivative, we can know that, given a specific guess x, will the final answer be larger (if the deriviative is negative) or smaller (if the derivative is positive). This is a **perfect clue of using binary search**.

So here is my answer
```python
class Solution:
    def minCost(self, nums: List[int], cost: List[int]) -> int:
        l = min(nums)
        r = max(nums)
        final_val = None
        while l < r:
            m = (l + r) // 2
            derivative = 0
            for n, c in zip(nums, cost):
                if m < n:
                    derivative -=  c
                else:
                    derivative += c
            
            if derivative < 0:
                l = m + 1
            else:
                r = m
        return sum([abs(n - l) * c for n, c in zip(nums, cost)])
```

##### **2449. Minimum Number of Operations to Make Arrays Similar**
```
You are given two positive integer arrays nums and target, of the same length.

In one operation, you can choose any two distinct indices i and j where 0 <= i, j < nums.length and:

set nums[i] = nums[i] + 2 and
set nums[j] = nums[j] - 2.
Two arrays are considered to be similar if the frequency of each element is the same.

Return the minimum number of operations required to make nums similar to target. The test cases are generated such that nums can always be similar to target.

 

Example 1:

Input: nums = [8,12,6], target = [2,14,10]
Output: 2
Explanation: It is possible to make nums similar to target in two operations:
- Choose i = 0 and j = 2, nums = [10,12,4].
- Choose i = 1 and j = 2, nums = [10,14,2].
It can be shown that 2 is the minimum number of operations needed.
Example 2:

Input: nums = [1,2,5], target = [4,1,3]
Output: 1
Explanation: We can make nums similar to target in one operation:
- Choose i = 1 and j = 2, nums = [1,4,3].
Example 3:

Input: nums = [1,1,1,1,1], target = [1,1,1,1,1]
Output: 0
Explanation: The array nums is already similiar to target.
 

Constraints:

n == nums.length == target.length
1 <= n <= 105
1 <= nums[i], target[i] <= 106
It is possible to make nums similar to target.
```

Again, I don't think this question follows any famous template, but it's very fun to answer it with some "ad-hoc" solution. This question is very similar to the following question
```
Given a list nums:List[int] and target:List[int], we are trying to make nums similar to target and each time we can only increase AND decrease element values by ONE!
```
For the above question, the answer is straightforward, i.e. we sort the target and nums, then do a ONE-TO-ONE mapping from the `nums[i]` to `target[i]`, eventually calculate the `sum` of `abs(nums[i] - target[i])`.

So I believe this question is essentially the same, but the only difference is that each time the number can only change by 2. This means that an even number can never be changed to odd. Therefore we have to group the `nums:List[int]` and `target:List[int]` by even / odd, then repeat the above process for each of the group, eventually return the sum.