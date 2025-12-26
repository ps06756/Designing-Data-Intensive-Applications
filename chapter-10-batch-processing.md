# Chapter 10: Batch Processing

## Introduction

There are three main types of systems:
1. **Services (online systems)**: Wait for request, send response, measured by response time
2. **Batch processing (offline systems)**: Take large input, produce output, measured by throughput
3. **Stream processing (near-real-time systems)**: Between batch and services, consume inputs shortly after they're produced

```mermaid
graph TB
    subgraph "Three Types of Systems"
        ONLINE["Online Systems<br/>Services, Web Apps<br/>Low latency<br/>Request-response"]

        BATCH["Batch Processing<br/>Data analytics, ETL<br/>High throughput<br/>Large datasets"]

        STREAM["Stream Processing<br/>Real-time analytics<br/>Continuous<br/>Event-driven"]
    end

    subgraph "Characteristics"
        O1["User waits<br/>for response"]
        B1["Scheduled jobs<br/>run periodically"]
        S1["Continuous<br/>processing"]
    end

    ONLINE -.-> O1
    BATCH -.-> B1
    STREAM -.-> S1

    style ONLINE fill:#90EE90
    style BATCH fill:#87CEEB
    style STREAM fill:#DDA0DD
```

This chapter focuses on **batch processing**: processing large amounts of data in a single job that takes minutes to days.

## 1. Batch Processing with Unix Tools

Let's start with a simple task: analyze web server logs to find the top 5 most popular URLs.

```mermaid
graph LR
    subgraph "Log File"
        LOG["access.log:<br/>192.168.1.1 - GET /home<br/>192.168.1.2 - GET /about<br/>192.168.1.1 - GET /home<br/>192.168.1.3 - GET /products<br/>192.168.1.1 - GET /home"]
    end

    subgraph "Desired Output"
        OUT["Top URLs:<br/>/home: 3<br/>/about: 1<br/>/products: 1"]
    end

    LOG --> OUT

    style LOG fill:#87CEEB
    style OUT fill:#90EE90
```

### Simple Log Analysis

**Using Unix tools**:
```bash
cat access.log |
  awk '{print $7}' |          # Extract URL (7th field)
  sort |                       # Sort URLs
  uniq -c |                    # Count unique URLs
  sort -rn |                   # Sort by count (descending)
  head -n 5                    # Take top 5
```

```mermaid
graph TB
    subgraph "Unix Pipeline"
        CAT["cat access.log<br/>Read file"]
        AWK["awk '{print $7}'<br/>Extract URL"]
        SORT1["sort<br/>Sort alphabetically"]
        UNIQ["uniq -c<br/>Count duplicates"]
        SORT2["sort -rn<br/>Sort by count"]
        HEAD["head -n 5<br/>Take top 5"]
    end

    CAT --> AWK
    AWK --> SORT1
    SORT1 --> UNIQ
    UNIQ --> SORT2
    SORT2 --> HEAD

    style CAT fill:#87CEEB
    style HEAD fill:#90EE90
```

**How it works**:

```mermaid
sequenceDiagram
    participant File as Log File
    participant Cat
    participant Awk
    participant Sort
    participant Uniq
    participant Output

    File->>Cat: Read lines
    Cat->>Awk: 192.168.1.1 - GET /home<br/>192.168.1.2 - GET /about<br/>...

    Awk->>Sort: /home<br/>/about<br/>/home<br/>/products<br/>/home
    Note over Awk: Extract URL field

    Sort->>Uniq: /about<br/>/home<br/>/home<br/>/home<br/>/products
    Note over Sort: Sort alphabetically

    Uniq->>Output: 1 /about<br/>3 /home<br/>1 /products
    Note over Uniq: Count consecutive<br/>duplicates
```

### The Unix Philosophy

```mermaid
graph TB
    subgraph "Unix Design Principles"
        P1["Make each program<br/>do one thing well"]
        P2["Expect output to become<br/>input to another program"]
        P3["Use simple,<br/>uniform interfaces"]
    end

    subgraph "Benefits"
        B1["✓ Composability"]
        B2["✓ Reusability"]
        B3["✓ Simplicity"]
    end

    P1 --> B1
    P2 --> B1
    P3 --> B2

    style P1 fill:#90EE90
    style P2 fill:#87CEEB
    style B1 fill:#ffeb3b
```

**Uniform interface**: Everything is a file (or stream of bytes)

```python
# Python equivalent of Unix pipeline
import sys
from collections import Counter

def extract_url(line):
    """Extract URL from log line"""
    parts = line.split()
    if len(parts) >= 7:
        return parts[6]
    return None

def process_log(filename):
    """Count URLs in log file"""
    url_counts = Counter()

    with open(filename, 'r') as f:
        for line in f:
            url = extract_url(line)
            if url:
                url_counts[url] += 1

    # Get top 5
    top_5 = url_counts.most_common(5)

    for url, count in top_5:
        print(f"{count} {url}")

# Usage
process_log('access.log')
```

**But Unix tools are better for ad-hoc analysis!**

### Sorting vs In-Memory Aggregation

```mermaid
graph TB
    subgraph "In-Memory Approach"
        MEM1["Read all data<br/>into memory"]
        MEM2["Hash table<br/>for counting"]
        MEM3["Problem: What if<br/>data doesn't fit<br/>in RAM?"]
    end

    subgraph "Sorting Approach"
        SORT1["Sort data<br/>on disk"]
        SORT2["Process sorted<br/>data linearly"]
        SORT3["✓ Works with<br/>datasets larger<br/>than RAM"]
    end

    MEM1 --> MEM2 --> MEM3
    SORT1 --> SORT2 --> SORT3

    style MEM3 fill:#ffcccc
    style SORT3 fill:#90EE90
```

**GNU sort** is remarkably efficient:
- Automatically uses disk when data exceeds memory
- Parallelizes sorting across CPU cores
- Can merge pre-sorted files

```bash
# Sort 100 GB file using only 1 GB RAM
sort --parallel=4 --buffer-size=1G huge_file.txt
```

### The Unix Pipe

**Pipe** (`|`) connects output of one program to input of another:

```mermaid
graph LR
    subgraph "Without Pipes"
        P1["Program 1"] --> TMP1["temp_file_1"]
        TMP1 --> P2["Program 2"]
        P2 --> TMP2["temp_file_2"]
        TMP2 --> P3["Program 3"]
    end

    subgraph "With Pipes"
        PP1["Program 1"] -->|"stdin/stdout"| PP2["Program 2"]
        PP2 -->|"stdin/stdout"| PP3["Program 3"]
    end

    style TMP1 fill:#ffcccc
    style TMP2 fill:#ffcccc
    style PP2 fill:#90EE90
```

**Benefits**:
- No temporary files on disk
- Programs run in parallel
- Backpressure: slower program controls rate

```mermaid
sequenceDiagram
    participant P1 as Program 1<br/>(producer)
    participant Pipe as OS Pipe Buffer
    participant P2 as Program 2<br/>(consumer)

    P1->>Pipe: Write data
    Note over Pipe: Buffer size: 64KB

    Pipe->>P2: Read data

    P1->>Pipe: Write more data
    Note over Pipe: Buffer filling up

    Note over P1: Buffer full!<br/>Block until space available

    Pipe->>P2: Read data
    Note over Pipe: Space available

    Note over P1: Resume writing
```

## 2. MapReduce and Distributed Filesystems

Unix tools work great on a single machine, but what about datasets that don't fit on one machine?

**MapReduce**: Like Unix tools, but distributed across thousands of machines.

```mermaid
graph TB
    subgraph "Unix Tools"
        UNIX["Single machine<br/>Pipes between processes<br/>Files on local disk"]
    end

    subgraph "MapReduce"
        MR["Many machines<br/>Network between processes<br/>Files on distributed filesystem"]
    end

    UNIX -.->|"Scale up"| MR

    style UNIX fill:#87CEEB
    style MR fill:#90EE90
```

### MapReduce Job Execution

```mermaid
graph TB
    subgraph "MapReduce Phases"
        INPUT["Input Files<br/>on HDFS"]

        MAP["Map Phase<br/>Process records<br/>emit key-value pairs"]

        SHUFFLE["Shuffle Phase<br/>Group by key<br/>Sort"]

        REDUCE["Reduce Phase<br/>Aggregate values<br/>per key"]

        OUTPUT["Output Files<br/>on HDFS"]
    end

    INPUT --> MAP
    MAP --> SHUFFLE
    SHUFFLE --> REDUCE
    REDUCE --> OUTPUT

    style MAP fill:#90EE90
    style SHUFFLE fill:#ffeb3b
    style REDUCE fill:#87CEEB
```

**Example: Count URL visits (like earlier Unix example)**

```python
# Map function
def mapper(record):
    """
    Input: Log line
    Output: (url, 1) pairs
    """
    url = extract_url(record)
    if url:
        yield (url, 1)

# Reduce function
def reducer(key, values):
    """
    Input: url, [1, 1, 1, ...]
    Output: (url, count)
    """
    yield (key, sum(values))
```

**Execution visualization**:

```mermaid
sequenceDiagram
    participant Input as Input Files
    participant M1 as Mapper 1
    participant M2 as Mapper 2
    participant M3 as Mapper 3
    participant Shuffle
    participant R1 as Reducer 1
    participant R2 as Reducer 2
    participant Output

    Input->>M1: Records 1-1000
    Input->>M2: Records 1001-2000
    Input->>M3: Records 2001-3000

    Note over M1,M3: Map phase:<br/>emit (url, 1) pairs

    M1->>Shuffle: (url1, 1), (url2, 1), ...
    M2->>Shuffle: (url1, 1), (url3, 1), ...
    M3->>Shuffle: (url2, 1), (url1, 1), ...

    Note over Shuffle: Shuffle phase:<br/>Group by key<br/>Sort by key

    Shuffle->>R1: url1: [1,1,1,...]
    Shuffle->>R2: url2: [1,1,...]

    Note over R1,R2: Reduce phase:<br/>Sum values

    R1->>Output: (url1, 15)
    R2->>Output: (url2, 8)
```

### Distributed Filesystem

MapReduce relies on a distributed filesystem (HDFS, GFS) to store input and output.

```mermaid
graph TB
    subgraph "HDFS Architecture"
        NN["NameNode<br/>Metadata:<br/>Which blocks<br/>are where"]

        DN1["DataNode 1<br/>Blocks: A1, B2, C1"]
        DN2["DataNode 2<br/>Blocks: A2, B1, C2"]
        DN3["DataNode 3<br/>Blocks: A3, B3, C3"]
    end

    subgraph "File Storage"
        FILE["Large file<br/>Split into blocks:<br/>A, B, C"]
    end

    FILE --> NN
    NN --> DN1
    NN --> DN2
    NN --> DN3

    style NN fill:#ffeb3b
    style DN1 fill:#90EE90
    style DN2 fill:#90EE90
    style DN3 fill:#90EE90
```

**Replication for fault tolerance**:

```mermaid
graph LR
    subgraph "File Block Replication"
        BLOCK["Block A<br/>64-128 MB"]

        REP1["Replica 1<br/>DataNode 1<br/>Rack 1"]
        REP2["Replica 2<br/>DataNode 2<br/>Rack 1"]
        REP3["Replica 3<br/>DataNode 3<br/>Rack 2"]
    end

    BLOCK --> REP1
    BLOCK --> REP2
    BLOCK --> REP3

    style BLOCK fill:#ffeb3b
    style REP1 fill:#90EE90
    style REP2 fill:#90EE90
    style REP3 fill:#90EE90
```

**Locality optimization**: Run computation where data is stored

```mermaid
graph TB
    subgraph "Data Locality"
        DATA1["DataNode 1<br/>Blocks: A, C"]
        DATA2["DataNode 2<br/>Blocks: B, D"]
        DATA3["DataNode 3<br/>Blocks: E, F"]
    end

    subgraph "Task Placement"
        TASK1["Mapper 1<br/>Process A, C<br/>on DataNode 1"]
        TASK2["Mapper 2<br/>Process B, D<br/>on DataNode 2"]
        TASK3["Mapper 3<br/>Process E, F<br/>on DataNode 3"]
    end

    DATA1 -.->|"No network transfer!"| TASK1
    DATA2 -.-> TASK2
    DATA3 -.-> TASK3

    style TASK1 fill:#90EE90
```

### MapReduce Workflows

Often need to chain multiple MapReduce jobs:

```mermaid
graph LR
    subgraph "Multi-Stage Pipeline"
        INPUT["Raw logs"]

        JOB1["Job 1: MapReduce<br/>Filter & clean"]
        OUT1["Cleaned data"]

        JOB2["Job 2: MapReduce<br/>Aggregate by user"]
        OUT2["User stats"]

        JOB3["Job 3: MapReduce<br/>Join with profiles"]
        FINAL["Final report"]
    end

    INPUT --> JOB1
    JOB1 --> OUT1
    OUT1 --> JOB2
    JOB2 --> OUT2
    OUT2 --> JOB3
    JOB3 --> FINAL

    style JOB1 fill:#90EE90
    style JOB2 fill:#87CEEB
    style JOB3 fill:#DDA0DD
```

**Problem**: Each job writes to and reads from HDFS (slow!)

```mermaid
graph TB
    subgraph "Materialization Between Jobs"
        J1["Job 1"]
        HDFS1["Write to HDFS<br/>Replicate 3x"]
        HDFS2["Read from HDFS"]
        J2["Job 2"]
    end

    J1 --> HDFS1
    HDFS1 --> HDFS2
    HDFS2 --> J2

    style HDFS1 fill:#ffcccc
    style HDFS2 fill:#ffcccc
```

### Joins in MapReduce

**Problem**: Join two datasets (e.g., user activity with user profiles)

```mermaid
graph LR
    subgraph "Datasets"
        ACTIVITY["Activity Log:<br/>user_id, page, time"]
        PROFILE["User Profiles:<br/>user_id, name, age"]
    end

    subgraph "Goal"
        JOINED["Joined Data:<br/>user_id, name, age,<br/>page, time"]
    end

    ACTIVITY --> JOINED
    PROFILE --> JOINED

    style ACTIVITY fill:#87CEEB
    style PROFILE fill:#90EE90
    style JOINED fill:#ffeb3b
```

**Sort-merge join**:

```mermaid
graph TB
    subgraph "Map Phase"
        M1["Mapper:<br/>Activity records<br/>emit (user_id, activity)"]
        M2["Mapper:<br/>Profile records<br/>emit (user_id, profile)"]
    end

    subgraph "Shuffle Phase"
        S["Group by user_id<br/>Sort by user_id"]
    end

    subgraph "Reduce Phase"
        R["Reducer:<br/>For each user_id,<br/>join activity with profile"]
    end

    M1 --> S
    M2 --> S
    S --> R

    style S fill:#ffeb3b
    style R fill:#90EE90
```

**Reducer input**:
```
user_id: 123
values: [
    ('activity', {page: '/home', time: '10:00'}),
    ('activity', {page: '/about', time: '10:05'}),
    ('profile', {name: 'Alice', age: 30})
]
```

```python
def reduce_side_join(key, values):
    """
    Join activity records with profile
    """
    profile = None
    activities = []

    for tag, record in values:
        if tag == 'profile':
            profile = record
        else:  # tag == 'activity'
            activities.append(record)

    # Join each activity with profile
    if profile:
        for activity in activities:
            yield {
                'user_id': key,
                'name': profile['name'],
                'age': profile['age'],
                'page': activity['page'],
                'time': activity['time']
            }
```

**Broadcast hash join** (when one dataset is small):

```mermaid
graph TB
    subgraph "Small Dataset"
        SMALL["User Profiles<br/>Fits in memory"]
    end

    subgraph "Large Dataset"
        LARGE["Activity Log<br/>Billions of records"]
    end

    subgraph "Join Strategy"
        BROADCAST["Broadcast<br/>small dataset<br/>to all mappers"]

        MAPPER["Each mapper:<br/>Load profiles in memory<br/>Join with activities<br/>No reduce needed!"]
    end

    SMALL --> BROADCAST
    BROADCAST --> MAPPER
    LARGE --> MAPPER

    style BROADCAST fill:#ffeb3b
    style MAPPER fill:#90EE90
```

### Group By in MapReduce

**Example**: Calculate average age per city

```python
# Map function
def mapper(record):
    """Emit (city, age)"""
    yield (record['city'], record['age'])

# Reduce function
def reducer(city, ages):
    """Calculate average"""
    ages_list = list(ages)
    avg_age = sum(ages_list) / len(ages_list)
    yield (city, avg_age)
```

```mermaid
graph TB
    subgraph "Execution"
        INPUT["Records:<br/>(Alice, SF, 30)<br/>(Bob, NY, 25)<br/>(Carol, SF, 35)<br/>(Dave, NY, 40)"]

        MAP["Map:<br/>(SF, 30)<br/>(NY, 25)<br/>(SF, 35)<br/>(NY, 40)"]

        SHUFFLE["Shuffle:<br/>SF: [30, 35]<br/>NY: [25, 40]"]

        REDUCE["Reduce:<br/>SF: 32.5<br/>NY: 32.5"]
    end

    INPUT --> MAP
    MAP --> SHUFFLE
    SHUFFLE --> REDUCE

    style SHUFFLE fill:#ffeb3b
```

### Handling Skew

**Problem**: Some keys have many more values than others (hot keys)

```mermaid
graph TB
    subgraph "Skewed Data"
        K1["Key: celebrity<br/>10M records"]
        K2["Key: regular_user_1<br/>10 records"]
        K3["Key: regular_user_2<br/>5 records"]
    end

    subgraph "Problem"
        REDUCER["One reducer<br/>gets 10M records<br/>Bottleneck!"]
    end

    K1 -.-> REDUCER

    style K1 fill:#ffcccc
    style REDUCER fill:#FF6347
```

**Solution**: Skewed join with sampling

```mermaid
graph TB
    subgraph "Solution"
        SAMPLE["Sample data<br/>Identify hot keys"]

        REPLICATE["Replicate hot key<br/>to multiple reducers<br/>(celebrity_1, celebrity_2, ...)"]

        PARALLEL["Process hot key<br/>in parallel<br/>across reducers"]

        COMBINE["Combine results<br/>in final stage"]
    end

    SAMPLE --> REPLICATE
    REPLICATE --> PARALLEL
    PARALLEL --> COMBINE

    style PARALLEL fill:#90EE90
```

## 3. Beyond MapReduce

MapReduce has limitations:
- Materializes intermediate state to HDFS (slow)
- Only supports map and reduce operations
- Verbose code for simple operations

```mermaid
graph TB
    subgraph "MapReduce Limitations"
        L1["❌ Intermediate results<br/>written to HDFS"]
        L2["❌ Only map & reduce<br/>primitives"]
        L3["❌ No optimization<br/>across jobs"]
        L4["❌ Slower for<br/>iterative algorithms"]
    end

    subgraph "Newer Systems"
        N1["✓ In-memory processing"]
        N2["✓ Rich operators"]
        N3["✓ Query optimization"]
        N4["✓ Fast iteration"]
    end

    style L1 fill:#ffcccc
    style N1 fill:#90EE90
```

### Dataflow Engines

**Spark, Flink, Tez**: More flexible than MapReduce

```mermaid
graph TB
    subgraph "MapReduce"
        MR1["Map"] --> MR2["HDFS"]
        MR2 --> MR3["Reduce"]
        MR3 --> MR4["HDFS"]
        MR4 --> MR5["Map"]
    end

    subgraph "Dataflow Engine"
        DF1["Operator 1"]
        DF2["Operator 2"]
        DF3["Operator 3"]
        DF4["Operator 4"]

        DF1 --> DF2
        DF2 --> DF3
        DF2 --> DF4
    end

    style MR2 fill:#ffcccc
    style MR4 fill:#ffcccc
    style DF2 fill:#90EE90
```

**Arbitrary DAG** (Directed Acyclic Graph) of operations:

```mermaid
graph TB
    subgraph "Dataflow DAG Example"
        INPUT1["Read logs"]
        INPUT2["Read profiles"]

        FILTER["Filter<br/>recent activity"]

        JOIN["Join<br/>logs with profiles"]

        GROUP1["Group by<br/>age bucket"]
        GROUP2["Group by<br/>city"]

        AGG1["Count<br/>per age bucket"]
        AGG2["Count<br/>per city"]

        UNION["Union<br/>results"]

        OUTPUT["Write output"]
    end

    INPUT1 --> FILTER
    FILTER --> JOIN
    INPUT2 --> JOIN

    JOIN --> GROUP1
    JOIN --> GROUP2

    GROUP1 --> AGG1
    GROUP2 --> AGG2

    AGG1 --> UNION
    AGG2 --> UNION

    UNION --> OUTPUT

    style JOIN fill:#ffeb3b
    style UNION fill:#90EE90
```

### Apache Spark

**Key idea**: Resilient Distributed Datasets (RDDs) with transformations

```python
# Spark example: Same URL counting task
from pyspark import SparkContext

sc = SparkContext()

# Read log file
logs = sc.textFile("hdfs://access.log")

# Extract URLs and count
url_counts = (logs
    .map(lambda line: extract_url(line))      # Extract URL
    .filter(lambda url: url is not None)      # Remove nulls
    .map(lambda url: (url, 1))                # Create pairs
    .reduceByKey(lambda a, b: a + b)          # Count
    .sortBy(lambda pair: pair[1], ascending=False)  # Sort
    .take(5))                                 # Top 5

for url, count in url_counts:
    print(f"{count} {url}")
```

**Lazy evaluation and optimization**:

```mermaid
graph LR
    subgraph "Transformations Build DAG"
        T1["textFile()"]
        T2["map()"]
        T3["filter()"]
        T4["reduceByKey()"]
        T5["sortBy()"]
    end

    subgraph "Action Triggers Execution"
        A1["take()"]
        OPTIMIZE["Optimizer:<br/>Combine operations<br/>Pipeline stages"]
        EXECUTE["Execute<br/>optimized plan"]
    end

    T1 --> T2 --> T3 --> T4 --> T5
    T5 --> A1
    A1 --> OPTIMIZE
    OPTIMIZE --> EXECUTE

    style OPTIMIZE fill:#ffeb3b
    style EXECUTE fill:#90EE90
```

**In-memory caching** for iterative algorithms:

```mermaid
graph TB
    subgraph "Iterative Algorithm"
        DATA["Initial data"]
        CACHE["Cache in memory"]

        ITER1["Iteration 1"]
        ITER2["Iteration 2"]
        ITER3["Iteration 3"]

        RESULT["Final result"]
    end

    DATA --> CACHE
    CACHE -.->|"Read from memory"| ITER1
    ITER1 --> CACHE
    CACHE -.->|"Read from memory"| ITER2
    ITER2 --> CACHE
    CACHE -.->|"Read from memory"| ITER3
    ITER3 --> RESULT

    style CACHE fill:#90EE90
```

```python
# Example: PageRank (iterative algorithm)
def pagerank(links, num_iterations=10):
    # Cache links in memory
    links = links.cache()

    # Initialize ranks
    ranks = links.mapValues(lambda urls: 1.0)

    # Iterate
    for iteration in range(num_iterations):
        # Calculate contributions
        contribs = links.join(ranks).flatMap(
            lambda url_urls_rank:
                [(dest, url_urls_rank[1][1] / len(url_urls_rank[1][0]))
                 for dest in url_urls_rank[1][0]]
        )

        # Update ranks
        ranks = contribs.reduceByKey(lambda a, b: a + b).mapValues(
            lambda rank: 0.15 + 0.85 * rank
        )

    return ranks
```

### Fault Tolerance in Dataflow Engines

**MapReduce**: Recompute failed tasks from HDFS

**Spark**: Recompute from lineage

```mermaid
graph TB
    subgraph "RDD Lineage"
        RDD1["RDD1<br/>textFile()"]
        RDD2["RDD2<br/>map()"]
        RDD3["RDD3<br/>filter()"]
        RDD4["RDD4<br/>reduceByKey()"]
    end

    RDD1 --> RDD2
    RDD2 --> RDD3
    RDD3 --> RDD4

    subgraph "Partition Failure"
        FAIL["RDD4 partition 2<br/>lost due to<br/>machine failure"]
    end

    subgraph "Recovery"
        RECOMPUTE["Recompute:<br/>1. RDD1 partition 2<br/>2. RDD2 partition 2<br/>3. RDD3 partition 2<br/>4. RDD4 partition 2"]
    end

    RDD4 -.-> FAIL
    FAIL --> RECOMPUTE

    style FAIL fill:#ffcccc
    style RECOMPUTE fill:#90EE90
```

**Checkpointing** for long lineages:

```mermaid
graph LR
    subgraph "Long Lineage"
        R1["RDD1"] --> R2["RDD2"]
        R2 --> R3["RDD3"]
        R3 --> R4["RDD4"]
        R4 --> R5["RDD5"]
        R5 --> R6["RDD6"]
        R6 --> R7["RDD7"]
    end

    subgraph "With Checkpointing"
        C1["RDD1"] --> C2["RDD2"]
        C2 --> CHECK1["Checkpoint"]
        CHECK1 --> C3["RDD3"]
        C3 --> C4["RDD4"]
        C4 --> CHECK2["Checkpoint"]
        CHECK2 --> C5["RDD5"]
    end

    style R7 fill:#ffcccc
    style CHECK1 fill:#90EE90
    style CHECK2 fill:#90EE90
```

### Materialization of Intermediate State

```mermaid
graph TB
    subgraph "When to Materialize"
        CASE1["Multiple downstream<br/>consumers"]
        CASE2["Wide transformations<br/>shuffle required"]
        CASE3["Checkpointing"]
    end

    subgraph "When to Pipeline"
        PIPE1["Single downstream<br/>consumer"]
        PIPE2["Narrow transformations<br/>map, filter"]
    end

    style CASE1 fill:#ffeb3b
    style PIPE1 fill:#90EE90
```

**Example**:

```mermaid
graph TB
    subgraph "Execution Plan"
        INPUT["Read input"]

        MAP1["map()<br/>filter()"]

        SHUFFLE["Shuffle<br/>Materialize!"]

        REDUCE["reduceByKey()"]

        MAP2["map()<br/>filter()"]

        OUTPUT["Write output"]
    end

    INPUT --> MAP1
    MAP1 -.->|"Pipeline in memory"| SHUFFLE
    SHUFFLE --> REDUCE
    REDUCE -.->|"Pipeline in memory"| MAP2
    MAP2 --> OUTPUT

    style SHUFFLE fill:#ffeb3b
```

## 4. Graph Processing

Many algorithms need to traverse graphs:
- Social network analysis
- PageRank
- Shortest paths
- Connected components

```mermaid
graph LR
    subgraph "Example Graph"
        A["A"] -->|"follows"| B["B"]
        A -->|"follows"| C["C"]
        B -->|"follows"| C
        C -->|"follows"| D["D"]
        D -->|"follows"| A
    end

    style A fill:#90EE90
    style B fill:#87CEEB
    style C fill:#DDA0DD
    style D fill:#FFB6C1
```

### Bulk Synchronous Parallel (BSP)

**Pregel model** (used by Apache Giraph, GraphX):

```mermaid
graph TB
    subgraph "BSP Execution Model"
        INIT["Initialize:<br/>Each vertex has<br/>initial state"]

        ITER["Iteration (superstep):<br/>1. Each vertex processes messages<br/>2. Updates its state<br/>3. Sends messages to neighbors"]

        SYNC["Barrier Synchronization:<br/>Wait for all vertices"]

        CHECK["Check:<br/>Active vertices?"]

        DONE["Done"]
    end

    INIT --> ITER
    ITER --> SYNC
    SYNC --> CHECK
    CHECK -->|"Yes"| ITER
    CHECK -->|"No"| DONE

    style SYNC fill:#ffeb3b
    style ITER fill:#90EE90
```

**Example: Finding shortest paths**

```python
class ShortestPathVertex:
    def __init__(self, vertex_id):
        self.id = vertex_id
        self.distance = float('inf')
        self.active = True

    def compute(self, messages):
        """Called in each superstep"""
        # Find minimum distance from messages
        if messages:
            min_dist = min(messages)
            if min_dist < self.distance:
                self.distance = min_dist
                # Send updated distance to neighbors
                for neighbor in self.neighbors:
                    self.send_message(neighbor, self.distance + 1)
            else:
                # No change, deactivate
                self.vote_to_halt()
```

**Execution visualization**:

```mermaid
sequenceDiagram
    participant V1 as Vertex A<br/>dist=0
    participant V2 as Vertex B<br/>dist=∞
    participant V3 as Vertex C<br/>dist=∞
    participant Sync as Barrier

    Note over V1,V3: Superstep 1

    V1->>V2: message: 1
    V1->>V3: message: 1

    V1->>Sync: Vote to halt
    V2->>Sync: Active
    V3->>Sync: Active

    Note over Sync: All vertices reach barrier

    Note over V1,V3: Superstep 2

    Note over V2: Receive: min(1) = 1<br/>Update distance = 1
    V2->>V3: message: 2

    Note over V3: Receive: min(1) = 1<br/>Update distance = 1

    V2->>Sync: Vote to halt
    V3->>Sync: Active

    Note over V1,V3: Superstep 3

    Note over V3: Receive: min(2) = 2<br/>Distance already 1, ignore

    V3->>Sync: Vote to halt

    Note over Sync: All vertices halted<br/>Algorithm terminates
```

### Graph Partitioning

**Challenge**: Distribute graph across machines

```mermaid
graph TB
    subgraph "Partitioning Strategies"
        RANDOM["Random:<br/>Simple but many<br/>cross-machine edges"]

        HASH["Hash by vertex ID:<br/>Easy but unbalanced"]

        SOCIAL["Social partitioning:<br/>Keep communities together<br/>Minimize cross-edges"]
    end

    style RANDOM fill:#ffcccc
    style HASH fill:#ffeb3b
    style SOCIAL fill:#90EE90
```

**Problem with poor partitioning**:

```mermaid
graph LR
    subgraph "Machine 1"
        M1_A["Vertex A"]
        M1_B["Vertex B"]
    end

    subgraph "Machine 2"
        M2_C["Vertex C"]
        M2_D["Vertex D"]
    end

    M1_A -->|"Network!"| M2_C
    M1_A -->|"Network!"| M2_D
    M1_B -->|"Network!"| M2_C
    M2_C -->|"Network!"| M1_A
    M2_D -->|"Network!"| M1_A

    style M1_A fill:#ffcccc
```

**Good partitioning**:

```mermaid
graph TB
    subgraph "Machine 1 - Community A"
        C1_A["Vertex A"]
        C1_B["Vertex B"]
        C1_C["Vertex C"]

        C1_A --> C1_B
        C1_B --> C1_C
        C1_C --> C1_A
    end

    subgraph "Machine 2 - Community B"
        C2_D["Vertex D"]
        C2_E["Vertex E"]
        C2_F["Vertex F"]

        C2_D --> C2_E
        C2_E --> C2_F
    end

    C1_C -.->|"Few cross-edges"| C2_D

    style C1_A fill:#90EE90
    style C2_D fill:#87CEEB
```

## 5. Comparing Batch Processing Systems

```mermaid
graph TB
    subgraph "Unix Tools"
        U1["✓ Simple, composable"]
        U2["✓ Fast on single machine"]
        U3["❌ Limited to one machine"]
    end

    subgraph "MapReduce"
        M1["✓ Distributed, scalable"]
        M2["✓ Fault tolerant"]
        M3["❌ Slow (HDFS I/O)"]
        M4["❌ Limited operators"]
    end

    subgraph "Dataflow Engines"
        D1["✓ Faster than MapReduce"]
        D2["✓ Rich operators"]
        D3["✓ In-memory processing"]
        D4["❌ More complex"]
    end

    style U1 fill:#90EE90
    style U3 fill:#ffcccc
    style M1 fill:#90EE90
    style M3 fill:#ffcccc
    style D1 fill:#90EE90
```

**Performance comparison**:

```mermaid
graph LR
    subgraph "Relative Performance"
        UNIX["Unix tools<br/>1x<br/>Single machine"]

        MR["MapReduce<br/>10-100x slower<br/>Distributed"]

        SPARK["Spark<br/>2-10x slower<br/>Distributed,<br/>in-memory"]
    end

    UNIX -.->|"Add distribution"| MR
    MR -.->|"Optimize"| SPARK

    style UNIX fill:#90EE90
    style MR fill:#ffcccc
    style SPARK fill:#ffeb3b
```

### Use Cases

```mermaid
graph TB
    subgraph "When to Use Each"
        UNIX_USE["Unix Tools:<br/>Single machine<br/>Ad-hoc analysis<br/>< 100 GB"]

        MR_USE["MapReduce:<br/>Very large datasets<br/>Mature ecosystem<br/>Need HDFS integration"]

        SPARK_USE["Spark:<br/>Iterative algorithms<br/>Machine learning<br/>Interactive queries"]

        GRAPH_USE["Graph Processing:<br/>Social networks<br/>PageRank<br/>Graph algorithms"]
    end

    style UNIX_USE fill:#90EE90
    style MR_USE fill:#87CEEB
    style SPARK_USE fill:#DDA0DD
    style GRAPH_USE fill:#FFB6C1
```

### Declarative Query Languages

**High-level SQL** on top of batch systems:

```mermaid
graph TB
    subgraph "SQL to Execution"
        SQL["SQL Query:<br/>SELECT city, AVG(age)<br/>FROM users<br/>GROUP BY city"]

        OPTIMIZER["Query Optimizer:<br/>Choose join order<br/>Select indexes<br/>Optimize execution"]

        PLAN["Physical Plan:<br/>Scan -> Filter -><br/>Group -> Aggregate"]

        EXECUTE["Execute on:<br/>Spark / Tez / Hive"]
    end

    SQL --> OPTIMIZER
    OPTIMIZER --> PLAN
    PLAN --> EXECUTE

    style OPTIMIZER fill:#ffeb3b
    style EXECUTE fill:#90EE90
```

**Examples**:
- **Hive**: SQL on MapReduce/Tez/Spark
- **Spark SQL**: SQL on Spark
- **Presto**: SQL for interactive queries

```sql
-- Same query works across systems
SELECT
    city,
    AVG(age) as avg_age,
    COUNT(*) as user_count
FROM users
WHERE signup_date > '2024-01-01'
GROUP BY city
HAVING COUNT(*) > 100
ORDER BY avg_age DESC;
```

## Summary

```mermaid
graph TB
    subgraph "Batch Processing Evolution"
        UNIX["Unix Philosophy:<br/>Simple tools,<br/>composable via pipes"]

        MR["MapReduce:<br/>Distributed processing,<br/>fault tolerance"]

        DF["Dataflow Engines:<br/>Flexible DAGs,<br/>in-memory processing"]

        SQL["SQL Layers:<br/>Declarative queries,<br/>optimized execution"]
    end

    UNIX -.->|"Scale to many machines"| MR
    MR -.->|"Improve performance"| DF
    DF -.->|"Simplify programming"| SQL

    style UNIX fill:#87CEEB
    style MR fill:#DDA0DD
    style DF fill:#90EE90
    style SQL fill:#ffeb3b
```

**Key Takeaways**:

1. **Unix philosophy still relevant**:
   - Simple, composable tools
   - Uniform interfaces (stdin/stdout)
   - Separation of concerns

2. **MapReduce pioneered distributed batch processing**:
   - Fault tolerance through replication
   - Data locality optimization
   - But limited by materialization overhead

3. **Dataflow engines improve on MapReduce**:
   - Arbitrary DAGs instead of just map/reduce
   - Pipeline operations in memory
   - Better for iterative algorithms

4. **Different models for different problems**:
   - Sort-merge joins for large datasets
   - Broadcast joins for small datasets
   - Graph processing for connected data

5. **Fault tolerance strategies**:
   - MapReduce: Re-execute from HDFS
   - Spark: Recompute from lineage
   - Trade-off: Recomputation vs materialization

6. **High-level abstractions winning**:
   - SQL on batch engines
   - Declarative > imperative
   - Query optimization opportunities

**Comparison table**:

| System | Strengths | Weaknesses | Best For |
|--------|-----------|------------|----------|
| **Unix tools** | Simple, fast on single machine | Doesn't scale | Ad-hoc analysis, small data |
| **MapReduce** | Scalable, fault tolerant, mature | Slow, limited operators | Very large batch jobs |
| **Spark** | Fast, rich API, in-memory | More memory required | Iterative ML, interactive queries |
| **Pregel/Giraph** | Optimized for graphs | Limited to graph algorithms | Social networks, PageRank |

---

**Next**: [Chapter 11: Stream Processing] - Processing unbounded data in real-time (not yet written)

**Previous**: [Chapter 9: Consistency and Consensus](./chapter-9-consistency-consensus.md)
