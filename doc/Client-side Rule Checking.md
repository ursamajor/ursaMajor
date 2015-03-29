Client-side Rule Checking
=========================

Motivation
----------

### server-side

-   takes up our resources :(
-   slow for checking (time grows exponentially with number of courses
    in plan)
-   slow for back/forth response (have to make/receive http requests
    to/from server)
-   result might not make it through
-   increased wait time for users (back/forth time + checking time)

### client-side

-   rule checking done by user's machine, saves resources on our end :)
-   fast checking (time grows linearly with number of courses in plan)
-   don't have to make additional http requests
-   will always have result
-   rules update instantly (so to speak)

### summary

|                                  | server-side           | client-side           |
| -------------------------------- | --------------------- | --------------------- |
| resources                        | ours                  | users’                |
| time (rel. to #courses in plan)  | exponential           | linear                |
| communication                    | takes time, can fail  | instant, can’t fail   |


How it works
------------

### naive implementation

-   rule object

        {
            name: "IMARULE",
            num_courses: 2,
            num_units: 8
        }
-   keep track of how many courses are tagged with "IMARULE"
    (totalCourses)
-   add their units together (totalUnits)
-   rule passes if totalCourses >= num_courses and totalUnits >=
    num_units

### drawbacks

-   can't handle rules that don't have a set number of courses or units
    ex. the overall major can be satisfied with a variable number of
    courses/units just because you have a large number of units or
    courses, doesn't mean you've satisfied the major

### solution

-   rule object

        {
            name: "IMACOOLERRULE",
            num_courses: 0,
            num_units:0,
            bool_op: "AND",
            subrules:
            [
                {
                    name: "IMARULE",
                    num_courses: 2
                    num_units: 8
                    bool_op: "none"
                    subrules: []
                }
            ]
        }

-   break down rules so that each piece works with the naive solution
    (i.e. you can tell if you passed it by checking num_courses or
    num_units)

-   a rule passes if totalCourses >= num_courses, totalUnits >=
    num_units, AND X
    X can be
    -   all subrules pass (bool_op: "AND")
    -   one of the subrules passes (bool_op: "OR")

-   for updating old rules:
    -   if the main rule is a same_course, course_regex, course, OR,
        etc. where it can be satisfied by a single course, then it
        should be fine as is (it's the equivalent of having num_courses
        = 1)
    -   if it is an AND, then it will most likely need to be rewritten
        as a count_courses or units
        -   if the rule can be satisfied by a variable number of
            units/courses (see phys_math in moltox in the original
            test-rules.yaml), then break it down into the largest blocks
            you can that are count_courses/units subrules (see below)

### example

1.  original

        phys_math:
            description: "Physical Sciences and Math (26-28 units)"
            rule: AND
            args:
                - OR:
                    - AND:
                        - course: MATH.16A
                        - course: MATH.16B
                        - course: STAT.2
                    - AND:
                        - course: MATH.1A
                        - course: STAT.2
                    - AND:
                        - course: MATH.10A
                        - course: MATH.10B
                - course: CHEM.1A
                - course: CHEM.1AL
                - course: CHEM.3A
                - course: CHEM.3AL
                - course: CHEM.3B
                - course: CHEM.3BL
                - course: PHYSICS.8A

2.  break down into largest possible pieces that work with naive
    solution (can be passed by checking num_courses/units) sometimes
    you will have to break down even those pieces

        phys_math:
            description: "Physical Sciences and Math (26-28 units)"
            rule: AND
            args:
                - OR:
                    - rule: math1
                    - rule: math2
                    - rule: math3
                - course: CHEM.1A
                - course: CHEM.1AL
                - course: CHEM.3A
                - course: CHEM.3AL
                - course: CHEM.3B
                - course: CHEM.3BL
                - course: PHYSICS.8A

3.  ideally, you would break it down further

        phys_math:
            description: "Physical Sciences and Math (26-28 units)"
            rule: AND
            args:
                - rule: math
                - course: CHEM.1A
                - course: CHEM.1AL
                - course: CHEM.3A
                - course: CHEM.3AL
                - course: CHEM.3B
                - course: CHEM.3BL
                - course: PHYSICS.8A

4.  and further

        phys_math:
            description: "Physical Sciences and Math (26-28 units)"
            rule: AND
            args:
                - rule: math
                - rule: physical

    since that means the front-end would only have to check two tags
    (broken down 3 times) as opposed to 8 (broken down twice), or 10
    (broken down once)
