---
layout: post
title: Learning Notes 'System Architecture Foundations'
category: [Lecture Notes, System Design]
excerpt: LinkedIn Learning
---


| Infomration             | Value                                                                                                                                                                                                  |
|:------------------------|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Course Link             | [LinkedIn Learning: System Architecture Foundations](https://www.linkedin.com/learning/software-architecture-foundations/what-is-software-architecture?autoSkip=true&autoplay=true&resume=false&u=104) |
| Learning Date           | 2022-05-05                                                                                                                                                                                             | 
| Why Taking this course? | Wanna learn systematic way of designing complex software system.                                                                                                                                       |
| Summary                 | I learned the design process of complex system, along with 5 common architecture patterns                                                                                                              |

**Architect**
- Everything starting from customers and centered on communication, rather than starting form techniques.
    - Agile architect:
      - How to break the chicken-egg problem between "user requirement" and "software development result": use "inspect and adapt loop" (i.e. building MVP and get early feedbacks). More specifically, the 4-step cycles consisting of:
      - Develop --> review --> talk to user --> refine --> (repeat this cycle)
      - Cycle around 2 days. 
    - Everyone is architect (no need permission as architect). 
      - Agile architect job is : teaching, coaching, coordinating 
      - Agile architect job is: keep the big thing in the head rather than low-level code. Developer know the code best. 
    - From developer to architect:
      - Good at programming 
      - At least read code (open source projects)


**Thinking Architecturally:**
- Conway's law:
  - Agile development: require both system architecture and development style to be agile 
    - System architecture: microservice (very thin and tall piece from frontend to backend that one developer handle)
    - Development style: quick experiment and quick feedbacks.
- Agile: Incremental development (one piece at a time), instead of big up-front design. (BUFD). Agile development will postpone the technical decision but more emphasize user requirements.



**Design Process**
- Start with "Problem Statement"  describe the problem and solution if the computer doesn't exist. Describe the problem in the form of a set of "user stories" (each user story is a requirement of small piece)
- Narrowing w/ slice and dice (draw a high-level picture with many if-condition, and each path is a narrow's scope)


**Category of Architecture**
- System architecture
- Enterprise architecture (it's a failed approach due to complex): structure of business structure/process itself; structure of code should reflect business process



**Architecture Pattern**
- Pattern 1: Monolith 
  - What is "monolith": an all-in-one system that contain complex components in a single system. 
  - Pro: (almost no)
  - Cons: very hard to maintain 
  - Type 1: N-tiers (one types of monolith containing 
    - UI 
    - Business Logic 
    - Database 
  - Type 2: Vertical divisions (very narrow-scope service where each include independent database and UI).

- Pattern 2: Microkernel Pattern 
  - How:
    - Core service handle core logic.
    - Other auxiliary service are plug-ins to these services. 
  - Application: This types of architecture not only for operation system, but also can be used for business application. 
  - Pro: isolation between core kernels avoid big ball of mud dependencies. Also, the plugins are usually small and easy to write. 
  - Cons: APIs to the kernel are delicate.

- Pattern 3: Message-based architecture. 
  - Example 1: Job run independently and communicate via message (a small piece of encapsule information) on message bus. 
  - Each job can either talk to each other directly, or via a intermediate bloker. 
  - Example 2: Pub/sub system: rather than using queue, receiver agent subscribe to a broker. 

- Pattern 4: Microservice 
  - Large service is made up of many small independent services. 
  - requirement:
    - Small (100 line of codes)
    - Independently deployable (most important)
    - Fully autonomous (own database)
    - Hide implementation details 
    - Almost always distributed. 

- Pattern 5: Reactive pattern.