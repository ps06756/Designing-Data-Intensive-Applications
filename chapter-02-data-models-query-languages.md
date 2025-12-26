# Chapter 2: Data Models and Query Languages

## Introduction

Data models are one of the most important parts of developing software, because they have such a profound effect on how we think about the problem we're solving and how we write the software.

```mermaid
graph TB
    subgraph "Layers of Abstraction"
        APP["Application Layer:<br/>Objects, data structures,<br/>APIs"]
        MODEL["Data Model Layer:<br/>Tables, documents, graphs,<br/>JSON, XML"]
        STORAGE["Storage Layer:<br/>Bytes in memory, disk,<br/>network"]
        HW["Hardware Layer:<br/>Electrical currents,<br/>magnetic fields"]
    end

    APP --> MODEL
    MODEL --> STORAGE
    STORAGE --> HW

    style APP fill:#90EE90
    style MODEL fill:#87CEEB
    style STORAGE fill:#DDA0DD
    style HW fill:#FFB6C1
```

Each layer hides the complexity of the layers below by providing a clean data model. These abstractions allow different groups of people to work together effectively.

This chapter explores the most important data models for data-intensive applications:
- **Relational model** (SQL)
- **Document model** (NoSQL)
- **Graph model**

## 1. Relational Model vs Document Model

### The Relational Model

Proposed by Edgar Codd in 1970, the relational model organizes data into **relations** (tables), where each relation is a collection of **tuples** (rows).

```mermaid
graph TB
    subgraph "Relational Database Example"
        USERS["Users Table<br/>--------------<br/>id | name | email"]
        POSTS["Posts Table<br/>--------------<br/>id | user_id | title | content"]
        COMMENTS["Comments Table<br/>--------------<br/>id | post_id | user_id | text"]
    end

    POSTS -->|"Foreign Key:<br/>user_id"| USERS
    COMMENTS -->|"Foreign Key:<br/>post_id"| POSTS
    COMMENTS -->|"Foreign Key:<br/>user_id"| USERS

    style USERS fill:#90EE90
    style POSTS fill:#87CEEB
    style COMMENTS fill:#DDA0DD
```

**Key characteristics**:
- Data organized in tables with fixed schema
- Relationships represented by foreign keys
- Queries use SQL (Structured Query Language)
- ACID transactions for consistency

**Example schema**:
```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE posts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    title VARCHAR(200),
    content TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE comments (
    id SERIAL PRIMARY KEY,
    post_id INTEGER REFERENCES posts(id),
    user_id INTEGER REFERENCES users(id),
    text TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);
```

### The Document Model

Document databases (MongoDB, CouchDB) store data as self-contained documents (usually JSON or XML).

```mermaid
graph TB
    subgraph "Document Database Example"
        DOC1["User Document 1<br/>-------------------<br/>{<br/>  id: 1,<br/>  name: 'Alice',<br/>  posts: [...]<br/>}"]
        DOC2["User Document 2<br/>-------------------<br/>{<br/>  id: 2,<br/>  name: 'Bob',<br/>  posts: [...]<br/>}"]
    end

    subgraph "Embedded Structure"
        NESTED["Nested Data:<br/>Posts and comments<br/>embedded within<br/>user document"]
    end

    DOC1 -.-> NESTED
    DOC2 -.-> NESTED

    style DOC1 fill:#90EE90
    style DOC2 fill:#87CEEB
    style NESTED fill:#ffeb3b
```

**Key characteristics**:
- Data stored as documents (JSON, BSON, XML)
- Schema flexibility (schemaless or schema-on-read)
- Related data often embedded in same document
- Natural fit for hierarchical data

**Example document**:
```json
{
    "_id": "user_1",
    "name": "Alice Johnson",
    "email": "alice@example.com",
    "location": {
        "city": "San Francisco",
        "state": "CA",
        "country": "USA"
    },
    "posts": [
        {
            "id": "post_1",
            "title": "First Post",
            "content": "Hello World!",
            "created_at": "2024-01-15T10:00:00Z",
            "comments": [
                {
                    "user": "Bob",
                    "text": "Great post!",
                    "created_at": "2024-01-15T11:00:00Z"
                }
            ]
        }
    ],
    "created_at": "2024-01-01T00:00:00Z"
}
```

### Comparison: Relational vs Document

```mermaid
graph TB
    subgraph "Data Representation"
        REL["Relational:<br/>Normalized tables<br/>with foreign keys"]
        DOC["Document:<br/>Nested structures<br/>with embedded data"]
    end

    subgraph "Trade-offs"
        subgraph "Relational Strengths"
            R1["✓ Strong schema"]
            R2["✓ Powerful joins"]
            R3["✓ Data consistency"]
            R4["✓ No duplication"]
        end

        subgraph "Document Strengths"
            D1["✓ Schema flexibility"]
            D2["✓ Better locality"]
            D3["✓ Natural nesting"]
            D4["✓ Easier scaling"]
        end
    end

    REL -.-> R1
    REL -.-> R2
    DOC -.-> D1
    DOC -.-> D2

    style REL fill:#87CEEB
    style DOC fill:#90EE90
```

### One-to-Many Relationships

**Relational approach**: Use foreign keys and joins

```sql
-- Query user with all posts
SELECT users.*, posts.*
FROM users
LEFT JOIN posts ON posts.user_id = users.id
WHERE users.id = 1;
```

```mermaid
sequenceDiagram
    participant App
    participant DB as Relational DB

    App->>DB: SELECT users with posts
    Note over DB: Join users table<br/>with posts table
    DB->>App: Multiple rows,<br/>need to assemble
    Note over App: Application assembles<br/>user object with posts array
```

**Document approach**: Embed related data

```javascript
// Query user with all posts
db.users.findOne({ _id: "user_1" })
// Returns complete document with embedded posts
```

```mermaid
sequenceDiagram
    participant App
    participant DB as Document DB

    App->>DB: findOne user_1
    Note over DB: Single document<br/>with all data
    DB->>App: Complete document<br/>with nested posts
    Note over App: No assembly needed,<br/>data already structured
```

**Comparison**:

| Aspect | Relational | Document |
|--------|-----------|----------|
| **Data retrieval** | Multiple queries or joins | Single query |
| **Locality** | Poor (data scattered) | Good (data together) |
| **Duplication** | None (normalized) | Possible if embedded |
| **Schema changes** | ALTER TABLE required | Flexible, gradual migration |

### Many-to-One and Many-to-Many Relationships

**Problem**: Many entities reference the same data (e.g., many users in same city)

```mermaid
graph LR
    subgraph "Relational Solution"
        U1["User 1:<br/>city_id = 5"]
        U2["User 2:<br/>city_id = 5"]
        U3["User 3:<br/>city_id = 5"]
        CITY["Cities Table:<br/>id=5, name='SF'"]

        U1 --> CITY
        U2 --> CITY
        U3 --> CITY
    end

    subgraph "Document Solution"
        D1["User 1:<br/>city: 'SF'"]
        D2["User 2:<br/>city: 'SF'"]
        D3["User 3:<br/>city: 'SF'"]
    end

    style CITY fill:#90EE90
    style D1 fill:#ffcccc
    style D2 fill:#ffcccc
    style D3 fill:#ffcccc
```

**Relational advantages for many-to-one**:
- **No duplication**: City name stored once
- **Consistency**: Update city name in one place
- **Type safety**: Can enforce valid cities
- **Easy updates**: Rename city affects all users

**Document challenges for many-to-one**:
- Duplication: "San Francisco" stored in many documents
- Inconsistency risk: Some docs might have "SF", others "San Francisco"
- Hard to update: Must update all documents

```python
# Relational: Easy update
db.execute("UPDATE cities SET name = 'San Francisco Bay Area' WHERE id = 5")
# All users automatically see new name

# Document: Hard update
db.users.update_many(
    {"city": "San Francisco"},
    {"$set": {"city": "San Francisco Bay Area"}}
)
# Must find and update all documents
```

**Many-to-Many relationships** are even more challenging for documents:

```mermaid
graph TB
    subgraph "Example: Students and Courses"
        S1["Student: Alice"]
        S2["Student: Bob"]
        C1["Course: Math"]
        C2["Course: Physics"]

        S1 -.->|enrolled| C1
        S1 -.->|enrolled| C2
        S2 -.->|enrolled| C1
        S2 -.->|enrolled| C2
    end

    subgraph "Relational Solution"
        ENROLL["Enrollments Table:<br/>student_id | course_id<br/>1 | 1<br/>1 | 2<br/>2 | 1<br/>2 | 2"]
    end

    subgraph "Document Challenges"
        PROB["Problem: Can't embed both ways<br/>- Embed courses in students?<br/>- Embed students in courses?<br/>- Either way creates duplication"]
    end

    S1 --> ENROLL
    C1 --> PROB

    style ENROLL fill:#90EE90
    style PROB fill:#ffcccc
```

### Schema Flexibility

```mermaid
graph TB
    subgraph "Schema-on-Write vs Schema-on-Read"
        WRITE["Schema-on-Write<br/>Relational"]
        READ["Schema-on-Read<br/>Document"]
    end

    subgraph "Schema-on-Write"
        W1["Database enforces<br/>schema on writes"]
        W2["ALTER TABLE<br/>required for changes"]
        W3["Strong guarantees"]
        W4["Can be slow for<br/>large tables"]
    end

    subgraph "Schema-on-Read"
        R1["Application interprets<br/>structure on reads"]
        R2["Can write any<br/>structure"]
        R3["Flexible but<br/>risky"]
        R4["Instant schema<br/>changes"]
    end

    WRITE --> W1
    WRITE --> W2
    READ --> R1
    READ --> R2

    style WRITE fill:#87CEEB
    style READ fill:#90EE90
```

**Example: Adding a new field**

Relational (schema-on-write):
```sql
-- Must alter table
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- For large tables, this can lock the table for hours!
-- All existing rows get NULL for phone
```

Document (schema-on-read):
```javascript
// Just start writing documents with new field
db.users.insertOne({
    name: "Charlie",
    email: "charlie@example.com",
    phone: "555-1234"  // New field, no migration needed!
})

// Application must handle both old and new documents
const user = db.users.findOne({_id: userId})
const phone = user.phone || "Not provided"  // Handle missing field
```

**Trade-offs**:

```mermaid
graph LR
    subgraph "When to Use Schema-on-Write"
        SW1["All documents have<br/>same structure"]
        SW2["Strong consistency<br/>requirements"]
        SW3["Complex queries<br/>and joins"]
    end

    subgraph "When to Use Schema-on-Read"
        SR1["Heterogeneous data<br/>structure varies"]
        SR2["Rapid iteration<br/>frequent changes"]
        SR3["Data from<br/>external sources"]
    end

    style SW1 fill:#87CEEB
    style SR1 fill:#90EE90
```

### Data Locality

Document databases provide better **locality**: related data stored together.

```mermaid
graph TB
    subgraph "Relational: Poor Locality"
        Q1["Query: Get user profile<br/>with posts and comments"]
        D1["Disk Seek 1:<br/>Read user from<br/>users table"]
        D2["Disk Seek 2:<br/>Read posts from<br/>posts table"]
        D3["Disk Seek 3:<br/>Read comments from<br/>comments table"]

        Q1 --> D1 --> D2 --> D3
    end

    subgraph "Document: Good Locality"
        Q2["Query: Get user profile<br/>with posts and comments"]
        D4["Disk Seek 1:<br/>Read entire document<br/>All data together"]

        Q2 --> D4
    end

    style D1 fill:#ffcccc
    style D2 fill:#ffcccc
    style D3 fill:#ffcccc
    style D4 fill:#90EE90
```

**Performance impact**:
```python
import time

# Relational: Multiple round trips
def get_user_profile_relational(user_id):
    start = time.time()

    # Query 1: Get user
    user = db.execute("SELECT * FROM users WHERE id = %s", [user_id])

    # Query 2: Get posts
    posts = db.execute("SELECT * FROM posts WHERE user_id = %s", [user_id])

    # Query 3: Get comments for each post
    for post in posts:
        post.comments = db.execute(
            "SELECT * FROM comments WHERE post_id = %s",
            [post.id]
        )

    elapsed = time.time() - start
    print(f"Relational: {elapsed:.3f}s, {3 + len(posts)} queries")
    return user

# Document: Single query
def get_user_profile_document(user_id):
    start = time.time()

    # Single query gets everything
    user = db.users.find_one({"_id": user_id})

    elapsed = time.time() - start
    print(f"Document: {elapsed:.3f}s, 1 query")
    return user
```

**However**, locality has trade-offs:
- Updates to small part require rewriting entire document
- Document size is limited (MongoDB: 16MB)
- Not beneficial if you only need part of the document

## 2. Query Languages

### Declarative vs Imperative

```mermaid
graph TB
    subgraph "Query Paradigms"
        DEC["Declarative<br/>SQL, CSS"]
        IMP["Imperative<br/>JavaScript, Python"]
    end

    subgraph "Declarative: Specify WHAT"
        D1["Describe desired result"]
        D2["Database chooses HOW"]
        D3["Can optimize automatically"]
        D4["Easier to parallelize"]
    end

    subgraph "Imperative: Specify HOW"
        I1["Step-by-step instructions"]
        I2["Explicit control flow"]
        I3["Hard to optimize"]
        I4["Sequential execution"]
    end

    DEC --> D1
    DEC --> D2
    IMP --> I1
    IMP --> I2

    style DEC fill:#90EE90
    style IMP fill:#ffcccc
```

**Example: Get all users in California**

Imperative approach (JavaScript):
```javascript
function getUsersInCalifornia(users) {
    const results = []
    for (let i = 0; i < users.length; i++) {
        if (users[i].location.state === 'CA') {
            results.push(users[i])
        }
    }
    return results
}
```

Declarative approach (SQL):
```sql
SELECT * FROM users WHERE state = 'CA';
```

**Why declarative is better**:
- Database can choose optimal execution plan
- Can use indexes automatically
- Can parallelize execution
- More concise and clear
- Less room for bugs

### SQL (Structured Query Language)

SQL is the dominant declarative query language for relational databases.

```mermaid
graph TB
    subgraph "SQL Operations"
        SELECT["SELECT:<br/>Retrieve data"]
        INSERT["INSERT:<br/>Add data"]
        UPDATE["UPDATE:<br/>Modify data"]
        DELETE["DELETE:<br/>Remove data"]
    end

    subgraph "Advanced Features"
        JOIN["JOIN:<br/>Combine tables"]
        AGG["GROUP BY:<br/>Aggregate data"]
        SUB["Subqueries:<br/>Nested queries"]
        WINDOW["Window functions:<br/>Analytics"]
    end

    SELECT --> JOIN
    SELECT --> AGG
    SELECT --> SUB
    SELECT --> WINDOW

    style SELECT fill:#90EE90
    style JOIN fill:#87CEEB
    style AGG fill:#DDA0DD
```

**Common SQL patterns**:

```sql
-- Basic query
SELECT name, email FROM users WHERE age > 18;

-- Join multiple tables
SELECT users.name, COUNT(posts.id) as post_count
FROM users
LEFT JOIN posts ON posts.user_id = users.id
GROUP BY users.id, users.name
HAVING COUNT(posts.id) > 5;

-- Subquery
SELECT * FROM posts
WHERE user_id IN (
    SELECT id FROM users WHERE location = 'SF'
);

-- Window function
SELECT
    name,
    salary,
    AVG(salary) OVER (PARTITION BY department) as dept_avg
FROM employees;
```

### MapReduce

MapReduce is a programming model for processing large datasets in parallel.

```mermaid
graph LR
    subgraph "MapReduce Pipeline"
        INPUT["Input:<br/>Large dataset"]
        MAP["Map Phase:<br/>Process each record<br/>emit key-value pairs"]
        SHUFFLE["Shuffle:<br/>Group by key"]
        REDUCE["Reduce Phase:<br/>Aggregate values<br/>per key"]
        OUTPUT["Output:<br/>Results"]
    end

    INPUT --> MAP --> SHUFFLE --> REDUCE --> OUTPUT

    style MAP fill:#90EE90
    style REDUCE fill:#87CEEB
```

**Example: Count posts per user**

SQL approach:
```sql
SELECT user_id, COUNT(*) as post_count
FROM posts
GROUP BY user_id;
```

MapReduce approach (MongoDB):
```javascript
db.posts.mapReduce(
    // Map function: emit (user_id, 1) for each post
    function() {
        emit(this.user_id, 1);
    },

    // Reduce function: sum all values for each user_id
    function(key, values) {
        return Array.sum(values);
    },

    // Output
    { out: "posts_per_user" }
)
```

**MapReduce execution**:
```mermaid
sequenceDiagram
    participant Input as Input Docs
    participant Map
    participant Shuffle
    participant Reduce
    participant Output

    Note over Input: {user_id: 1, title: "Post A"}<br/>{user_id: 2, title: "Post B"}<br/>{user_id: 1, title: "Post C"}

    Input->>Map: Process each document
    Note over Map: emit(1, 1)<br/>emit(2, 1)<br/>emit(1, 1)

    Map->>Shuffle: Group by key
    Note over Shuffle: 1: [1, 1]<br/>2: [1]

    Shuffle->>Reduce: Reduce each group
    Note over Reduce: 1: sum([1,1]) = 2<br/>2: sum([1]) = 1

    Reduce->>Output: Final results
    Note over Output: {user_id: 1, count: 2}<br/>{user_id: 2, count: 1}
```

**MapReduce vs SQL**:

| Aspect | SQL | MapReduce |
|--------|-----|-----------|
| **Abstraction** | High-level, declarative | Lower-level, imperative |
| **Flexibility** | Limited to SQL operations | Arbitrary JavaScript code |
| **Optimization** | Database optimizes | Manual optimization |
| **Ease of use** | Easier for common queries | More complex |
| **Use case** | Standard analytics | Custom processing logic |

### Aggregation Pipeline

Modern document databases offer aggregation pipelines as a middle ground.

```mermaid
graph TB
    subgraph "Aggregation Pipeline"
        INPUT["Input<br/>Documents"]
        STAGE1["Stage 1:<br/>$match<br/>Filter"]
        STAGE2["Stage 2:<br/>$group<br/>Aggregate"]
        STAGE3["Stage 3:<br/>$sort<br/>Order"]
        OUTPUT["Output<br/>Results"]
    end

    INPUT --> STAGE1 --> STAGE2 --> STAGE3 --> OUTPUT

    style STAGE1 fill:#90EE90
    style STAGE2 fill:#87CEEB
    style STAGE3 fill:#DDA0DD
```

**Example: Average post length per user**

```javascript
db.posts.aggregate([
    // Stage 1: Calculate length of each post
    {
        $project: {
            user_id: 1,
            length: { $strLenCP: "$content" }
        }
    },

    // Stage 2: Group by user and calculate average
    {
        $group: {
            _id: "$user_id",
            avg_length: { $avg: "$length" },
            post_count: { $sum: 1 }
        }
    },

    // Stage 3: Sort by average length
    {
        $sort: { avg_length: -1 }
    },

    // Stage 4: Limit to top 10
    {
        $limit: 10
    }
])
```

**Comparison**:
```python
# Same query in different approaches

# SQL
"""
SELECT
    user_id,
    AVG(LENGTH(content)) as avg_length,
    COUNT(*) as post_count
FROM posts
GROUP BY user_id
ORDER BY avg_length DESC
LIMIT 10;
"""

# MongoDB Aggregation Pipeline
[
    {"$project": {"user_id": 1, "length": {"$strLenCP": "$content"}}},
    {"$group": {"_id": "$user_id", "avg_length": {"$avg": "$length"}, "post_count": {"$sum": 1}}},
    {"$sort": {"avg_length": -1}},
    {"$limit": 10}
]

# MapReduce (more verbose, less efficient)
# ... map and reduce functions ...
```

## 3. Graph Databases

Some applications have data that's more naturally modeled as a graph: **nodes** (entities) and **edges** (relationships).

```mermaid
graph LR
    subgraph "Graph Database Example: Social Network"
        A["Alice"]
        B["Bob"]
        C["Charlie"]
        D["Diana"]

        SF["San Francisco"]
        NY["New York"]

        POST1["Post: Hello"]
        POST2["Post: Graphs!"]

        A -->|FRIENDS_WITH| B
        B -->|FRIENDS_WITH| C
        A -->|FRIENDS_WITH| D
        D -->|FRIENDS_WITH| C

        A -->|LIVES_IN| SF
        B -->|LIVES_IN| SF
        C -->|LIVES_IN| NY
        D -->|LIVES_IN| NY

        A -->|POSTED| POST1
        B -->|LIKED| POST1
        C -->|POSTED| POST2
        A -->|LIKED| POST2
    end

    style A fill:#90EE90
    style B fill:#87CEEB
    style C fill:#DDA0DD
    style D fill:#FFB6C1
```

### Property Graphs

In the **property graph** model:
- Each **node** has:
  - Unique identifier
  - Set of outgoing edges
  - Set of incoming edges
  - Collection of properties (key-value pairs)

- Each **edge** has:
  - Unique identifier
  - Starting node (tail vertex)
  - Ending node (head vertex)
  - Label to describe relationship
  - Collection of properties

```mermaid
graph TB
    subgraph "Property Graph Structure"
        NODE["Node<br/>---------<br/>id<br/>label<br/>properties: {}<br/>outgoing_edges<br/>incoming_edges"]

        EDGE["Edge<br/>---------<br/>id<br/>label<br/>properties: {}<br/>tail_vertex<br/>head_vertex"]
    end

    NODE -->|has| EDGE

    style NODE fill:#90EE90
    style EDGE fill:#87CEEB
```

**Example in Cypher (Neo4j query language)**:
```cypher
// Create nodes
CREATE (alice:Person {name: 'Alice', age: 30, location: 'SF'})
CREATE (bob:Person {name: 'Bob', age: 28, location: 'SF'})
CREATE (sf:City {name: 'San Francisco', state: 'CA'})

// Create relationships
CREATE (alice)-[:FRIENDS_WITH {since: 2020}]->(bob)
CREATE (alice)-[:LIVES_IN]->(sf)
CREATE (bob)-[:LIVES_IN]->(sf)
```

### Graph Queries

Graph databases excel at traversing relationships.

```mermaid
sequenceDiagram
    participant User
    participant Graph as Graph DB
    participant Result

    User->>Graph: Find friends of friends
    Note over Graph: Traverse FRIENDS_WITH edges<br/>2 levels deep

    Graph->>Graph: Start at Alice node
    Graph->>Graph: Follow FRIENDS_WITH to Bob
    Graph->>Graph: Follow FRIENDS_WITH from Bob<br/>to Charlie, Diana

    Graph->>Result: Return {Charlie, Diana}
    Result->>User: Display results
```

**Example queries**:

```cypher
// 1. Find all friends of Alice
MATCH (alice:Person {name: 'Alice'})-[:FRIENDS_WITH]->(friend)
RETURN friend.name;

// 2. Find friends of friends (excluding direct friends and Alice herself)
MATCH (alice:Person {name: 'Alice'})-[:FRIENDS_WITH]->()-[:FRIENDS_WITH]->(foaf)
WHERE NOT (alice)-[:FRIENDS_WITH]->(foaf) AND foaf <> alice
RETURN DISTINCT foaf.name;

// 3. Find people who live in same city as Alice
MATCH (alice:Person {name: 'Alice'})-[:LIVES_IN]->(city)<-[:LIVES_IN]-(person)
WHERE person <> alice
RETURN person.name, city.name;

// 4. Shortest path between two people
MATCH path = shortestPath(
    (alice:Person {name: 'Alice'})-[:FRIENDS_WITH*]-(diana:Person {name: 'Diana'})
)
RETURN path;
```

### Graph Queries in SQL (for comparison)

The same queries in SQL require complex recursive queries:

```sql
-- Find friends of friends (painful in SQL!)
WITH RECURSIVE friends_of_friends AS (
    -- Base case: Direct friends
    SELECT
        friend_id,
        1 as depth
    FROM friendships
    WHERE user_id = (SELECT id FROM users WHERE name = 'Alice')

    UNION

    -- Recursive case: Friends of those friends
    SELECT
        f.friend_id,
        fof.depth + 1
    FROM friendships f
    JOIN friends_of_friends fof ON f.user_id = fof.friend_id
    WHERE fof.depth < 2
)
SELECT DISTINCT u.name
FROM friends_of_friends fof
JOIN users u ON u.id = fof.friend_id
WHERE fof.depth = 2
  AND fof.friend_id NOT IN (
      SELECT friend_id FROM friendships
      WHERE user_id = (SELECT id FROM users WHERE name = 'Alice')
  );
```

**Comparison**:

| Operation | Graph DB (Cypher) | Relational DB (SQL) |
|-----------|-------------------|---------------------|
| **Find friends** | Simple MATCH pattern | Simple JOIN |
| **Find friends-of-friends** | Simple MATCH pattern | Complex recursive CTE |
| **Variable-length paths** | Built-in support | Very complex |
| **Performance** | Optimized for traversal | Slower for deep relationships |
| **Flexibility** | Easy to add relationship types | Requires schema changes |

### Triple Stores

An alternative graph model is the **triple store**, where all information is stored as three-part statements: **subject**, **predicate**, **object**.

```mermaid
graph LR
    subgraph "Triple Store Example"
        T1["Alice, friends_with, Bob"]
        T2["Alice, age, 30"]
        T3["Alice, lives_in, SF"]
        T4["SF, state, CA"]
        T5["Bob, friends_with, Charlie"]
    end

    style T1 fill:#90EE90
    style T2 fill:#87CEEB
    style T3 fill:#DDA0DD
    style T4 fill:#FFB6C1
    style T5 fill:#F0E68C
```

**Example in Turtle format**:
```turtle
@prefix : <http://example.com/> .

:alice  :name        "Alice" ;
        :age         30 ;
        :friends_with :bob ;
        :lives_in    :sf .

:bob    :name        "Bob" ;
        :age         28 ;
        :friends_with :charlie ;
        :lives_in    :sf .

:sf     :name        "San Francisco" ;
        :state       "CA" .
```

**Querying with SPARQL**:
```sparql
# Find all friends of Alice
SELECT ?friendName WHERE {
    ?alice :name "Alice" .
    ?alice :friends_with ?friend .
    ?friend :name ?friendName .
}

# Find people in same city as Alice
SELECT ?personName ?cityName WHERE {
    ?alice :name "Alice" .
    ?alice :lives_in ?city .
    ?person :lives_in ?city .
    ?person :name ?personName .
    ?city :name ?cityName .
    FILTER (?person != ?alice)
}
```

### When to Use Graph Databases

```mermaid
graph TB
    subgraph "Graph DB Use Cases"
        UC1["Social Networks:<br/>Friends, followers,<br/>connections"]
        UC2["Recommendation<br/>Engines:<br/>Related products"]
        UC3["Fraud Detection:<br/>Transaction patterns,<br/>networks"]
        UC4["Knowledge Graphs:<br/>Entities and<br/>relationships"]
        UC5["Network Topology:<br/>IT infrastructure,<br/>dependencies"]
    end

    subgraph "When Graphs Excel"
        WHY["Many-to-many<br/>relationships<br/>+<br/>Variable depth<br/>traversals<br/>+<br/>Relationship<br/>properties matter"]
    end

    UC1 --> WHY
    UC2 --> WHY
    UC3 --> WHY
    UC4 --> WHY
    UC5 --> WHY

    style WHY fill:#90EE90
```

**Example: Fraud detection pattern**

```cypher
// Find suspicious transaction patterns
// (money rapidly moved through many accounts)
MATCH path = (start:Account)-[:TRANSFERRED*4..8]->(end:Account)
WHERE start.flagged = true
  AND ALL(r IN relationships(path) WHERE r.timestamp > datetime() - duration('PT24H'))
  AND reduce(total = 0, r IN relationships(path) | total + r.amount) > 100000
RETURN path, reduce(total = 0, r IN relationships(path) | total + r.amount) as total_amount
ORDER BY total_amount DESC;
```

This query would be extremely complex in SQL!

## 4. Choosing a Data Model

```mermaid
graph TB
    subgraph "Decision Tree"
        START["What kind of data?"]

        DOC_Q["Self-contained<br/>documents with<br/>hierarchical structure?"]
        GRAPH_Q["Complex many-to-many<br/>relationships with<br/>deep traversals?"]
        REL_Q["Structured data<br/>with complex queries<br/>and joins?"]

        DOC["Document DB<br/>MongoDB, CouchDB"]
        GRAPH["Graph DB<br/>Neo4j, Amazon Neptune"]
        REL["Relational DB<br/>PostgreSQL, MySQL"]
    end

    START --> DOC_Q
    DOC_Q -->|Yes| DOC
    DOC_Q -->|No| GRAPH_Q
    GRAPH_Q -->|Yes| GRAPH
    GRAPH_Q -->|No| REL_Q
    REL_Q -->|Yes| REL

    style DOC fill:#90EE90
    style GRAPH fill:#87CEEB
    style REL fill:#DDA0DD
```

### Detailed Comparison

```mermaid
graph TB
    subgraph "Relational Database"
        R1["✓ Well-established<br/>and mature"]
        R2["✓ Powerful query<br/>language SQL"]
        R3["✓ ACID transactions"]
        R4["✓ Good for complex<br/>joins"]
        R5["❌ Schema changes<br/>can be slow"]
        R6["❌ Impedance mismatch<br/>with OOP"]
    end

    subgraph "Document Database"
        D1["✓ Schema flexibility"]
        D2["✓ Good data locality"]
        D3["✓ Scales horizontally"]
        D4["✓ Natural for JSON"]
        D5["❌ Weak support<br/>for joins"]
        D6["❌ Data duplication"]
    end

    subgraph "Graph Database"
        G1["✓ Natural for<br/>relationships"]
        G2["✓ Flexible schema"]
        G3["✓ Great for<br/>traversals"]
        G4["✓ Expressive queries"]
        G5["❌ Not mature as<br/>relational"]
        G6["❌ Harder to<br/>scale writes"]
    end

    style R1 fill:#90EE90
    style R5 fill:#ffcccc
    style D1 fill:#90EE90
    style D5 fill:#ffcccc
    style G1 fill:#90EE90
    style G5 fill:#ffcccc
```

### Real-World Examples

**Use Relational when:**
```python
# Banking application
# - Strong ACID guarantees needed
# - Complex transactions between accounts
# - Structured financial reports

class BankingApp:
    def transfer_money(self, from_account, to_account, amount):
        with db.transaction():
            # Atomic: Both succeed or both fail
            db.execute(
                "UPDATE accounts SET balance = balance - %s WHERE id = %s",
                [amount, from_account]
            )
            db.execute(
                "UPDATE accounts SET balance = balance + %s WHERE id = %s",
                [amount, to_account]
            )
            db.execute(
                "INSERT INTO transactions (from, to, amount) VALUES (%s, %s, %s)",
                [from_account, to_account, amount]
            )
```

**Use Document when:**
```python
# Content management system
# - Articles with varying structure
# - Embedded comments and metadata
# - Rapid iteration on schema

class BlogApp:
    def create_article(self, article_data):
        # Flexible structure, can evolve over time
        db.articles.insert_one({
            "title": article_data["title"],
            "author": article_data["author"],
            "content": article_data["content"],
            "tags": article_data.get("tags", []),
            "metadata": article_data.get("metadata", {}),
            "comments": [],  # Embedded
            "versions": [],  # Keep history
            "created_at": datetime.now()
        })
```

**Use Graph when:**
```python
# Social network
# - Complex relationship queries
# - Friend recommendations
# - Influence analysis

class SocialApp:
    def recommend_friends(self, user_id):
        # Find friends of friends with common interests
        query = """
        MATCH (user:Person {id: $user_id})-[:FRIENDS_WITH]->(friend)
              -[:FRIENDS_WITH]->(foaf)
        WHERE NOT (user)-[:FRIENDS_WITH]->(foaf)
          AND foaf <> user
        MATCH (user)-[:INTERESTED_IN]->(interest)<-[:INTERESTED_IN]-(foaf)
        RETURN foaf.name, COUNT(interest) as common_interests
        ORDER BY common_interests DESC
        LIMIT 10
        """
        return graph.execute(query, user_id=user_id)
```

## Summary

Data models are perhaps the most important abstraction in software development.

```mermaid
graph TB
    subgraph "Key Takeaways"
        T1["Each data model<br/>embodies assumptions<br/>about usage"]
        T2["No one model<br/>is best for<br/>all use cases"]
        T3["Understanding trade-offs<br/>is crucial"]
    end

    subgraph "The Three Models"
        REL["Relational:<br/>Structured data,<br/>complex queries,<br/>strong consistency"]
        DOC["Document:<br/>Hierarchical data,<br/>schema flexibility,<br/>good locality"]
        GRAPH["Graph:<br/>Connected data,<br/>relationship-focused,<br/>deep traversals"]
    end

    T1 --> REL
    T1 --> DOC
    T1 --> GRAPH

    style T1 fill:#ffeb3b
    style T2 fill:#ffeb3b
    style T3 fill:#ffeb3b
    style REL fill:#87CEEB
    style DOC fill:#90EE90
    style GRAPH fill:#DDA0DD
```

**Summary table**:

| Aspect | Relational | Document | Graph |
|--------|-----------|----------|-------|
| **Data structure** | Tables with rows | Documents (JSON/BSON) | Nodes and edges |
| **Schema** | Fixed, schema-on-write | Flexible, schema-on-read | Flexible |
| **Relationships** | Foreign keys, joins | Embedded or references | First-class edges |
| **Query language** | SQL | MongoDB query language, aggregation | Cypher, SPARQL |
| **Best for** | Structured, complex queries | Hierarchical, evolving data | Connected, graph traversal |
| **Strengths** | ACID, mature tooling | Locality, flexibility | Relationships, traversal |
| **Weaknesses** | Schema rigidity | Join limitations | Write scalability |
| **Examples** | PostgreSQL, MySQL | MongoDB, CouchDB | Neo4j, Neptune |

**Final thoughts**:
- Start with the data model that most naturally fits your data
- Many applications use multiple databases (polyglot persistence)
- The data model shapes how you think about the problem
- Consider access patterns, not just data structure
- Schema flexibility vs. data integrity is a key trade-off

---

**Next**: [Chapter 3: Storage and Retrieval] - How databases store data on disk and retrieve it efficiently (not yet written)

**Previous**: [Chapter 1: Reliable, Scalable, and Maintainable Applications](./chapter-1-reliable-scalable-maintainable.md)
