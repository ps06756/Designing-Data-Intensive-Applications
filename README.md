# Designing-Data-Intensive-Applications

This repository explains the concepts from "Designing Data-Intensive Applications" by Martin Kleppmann, with chapter-by-chapter breakdowns and practical examples.

Read it chapter by chapter, or study one topic at a time with the **Reading paths** and **Topics by theme** sections below.

## Chapters

- [Chapter 1: Reliable, Scalable, and Maintainable Applications](./chapter-01-reliable-scalable-maintainable.md) - Foundation chapter covering the three fundamental concerns in software systems: reliability (fault tolerance), scalability (handling growth), and maintainability (operability, simplicity, evolvability).

- [Chapter 2: Data Models and Query Languages](./chapter-02-data-models-query-languages.md) - Comprehensive exploration of data models including relational (SQL), document (NoSQL), and graph databases, along with their query languages, trade-offs, and when to use each model.

- [Chapter 3: Storage and Retrieval](./chapter-03-storage-retrieval.md) - Deep dive into how databases store and retrieve data, covering hash indexes, SSTables, LSM-trees, B-trees, and the differences between OLTP (row-oriented) and OLAP (column-oriented) storage engines.

- [Chapter 4: Encoding and Evolution](./chapter-04-encoding-evolution.md) - Comprehensive guide to data encoding formats (JSON, XML, Thrift, Protocol Buffers, Avro), schema evolution strategies, backward/forward compatibility, and dataflow patterns through databases, services, and message queues.

- [Chapter 5: Replication](./chapter-05-replication.md) - Explores replication strategies including single-leader, multi-leader, and leaderless replication, along with handling consistency challenges and conflicts.

- [Chapter 6: Partitioning](./chapter-06-partitioning.md) - Covers partitioning strategies (sharding) for scalability, including key-range and hash-based partitioning, secondary indexes, rebalancing techniques, and request routing approaches.

- [Chapter 7: Transactions](./chapter-07-transactions.md) - Deep dive into ACID properties, isolation levels (Read Committed, Snapshot Isolation, Serializable), concurrency control mechanisms (2PL, MVCC, SSI), and distributed transactions with two-phase commit.

- [Chapter 8: The Trouble with Distributed Systems](./chapter-08-distributed-systems-trouble.md) - Explores the fundamental challenges of distributed systems including unreliable networks, clock synchronization issues, process pauses, partial failures, Byzantine faults, and system models for reasoning about failures.

- [Chapter 9: Consistency and Consensus](./chapter-09-consistency-consensus.md) - Comprehensive coverage of consistency models (from eventual consistency to linearizability), ordering guarantees, causality, consensus algorithms (2PC, Paxos, Raft), and coordination services (ZooKeeper, etcd, Consul) for building fault-tolerant distributed systems.

- [Chapter 10: Batch Processing](./chapter-10-batch-processing.md) - In-depth exploration of batch processing systems from Unix tools to MapReduce and modern dataflow engines (Spark, Flink), covering distributed filesystems (HDFS), join algorithms, graph processing (Pregel model), fault tolerance strategies, and the evolution toward declarative SQL interfaces.

- [Chapter 11: Stream Processing](./chapter-11-stream-processing.md) - Comprehensive guide to stream processing covering event streams, message brokers (Kafka), change data capture (CDC), event sourcing, stream joins (stream-stream, stream-table), windowing operations, handling time and late events with watermarks, fault tolerance with exactly-once semantics, and comparison of stream processing frameworks.

- [Chapter 12: The Future of Data Systems](./chapter-12-future-data-systems.md) - Integrating everything together: data integration patterns, unbundling databases, derived data with Lambda and Kappa architectures, CQRS, end-to-end correctness with idempotence, enforcing constraints in distributed systems, trust and verification with audit logs, and ethical considerations for privacy and fairness in data systems design.

## Studying by topic

Every link below jumps straight to the section that covers a topic, so you don't need to read the whole chapter.

- **Reading paths** are ordered lists of sections for a specific goal.
- **Topics by theme** list each concept with:
  - **Start here**: the section that explains it.
  - **Also see**: other sections, often in other chapters, where the idea comes up again.
  - **Read first**: what you need to know for the section to make sense. Skip it if you already know the material.

## Reading paths

### How a database stores data

1. [Ch 3 · The Simplest Database](./chapter-03-storage-retrieval.md#the-simplest-database)
2. [Ch 3 · Hash Indexes](./chapter-03-storage-retrieval.md#2-hash-indexes)
3. [Ch 3 · SSTables and LSM-Trees](./chapter-03-storage-retrieval.md#3-sstables-and-lsm-trees)
4. [Ch 3 · B-Trees](./chapter-03-storage-retrieval.md#4-b-trees)
5. [Ch 3 · B-Tree vs LSM-Tree](./chapter-03-storage-retrieval.md#b-tree-vs-lsm-tree)
6. [Ch 7 · How Durability Works](./chapter-07-transactions.md#how-durability-works) (write-ahead log)
7. [Ch 3 · Transaction Processing vs Analytics](./chapter-03-storage-retrieval.md#6-transaction-processing-vs-analytics)
8. [Ch 3 · Column-Oriented Storage](./chapter-03-storage-retrieval.md#7-column-oriented-storage)

### Scaling out: replication and partitioning

1. [Ch 1 · Approaches for Coping with Load](./chapter-01-reliable-scalable-maintainable.md#23-approaches-for-coping-with-load)
2. [Ch 5 · Leaders and Followers](./chapter-05-replication.md#1-leaders-and-followers-single-leader-replication)
3. [Ch 5 · Synchronous vs. Asynchronous Replication](./chapter-05-replication.md#synchronous-vs-asynchronous-replication)
4. [Ch 5 · Problems with Replication Lag](./chapter-05-replication.md#3-problems-with-replication-lag)
5. [Ch 5 · Leaderless Replication](./chapter-05-replication.md#5-leaderless-replication)
6. [Ch 6 · Partitioning of Key-Value Data](./chapter-06-partitioning.md#1-partitioning-of-key-value-data)
7. [Ch 6 · Partitioning and Secondary Indexes](./chapter-06-partitioning.md#2-partitioning-and-secondary-indexes)
8. [Ch 6 · Rebalancing Partitions](./chapter-06-partitioning.md#3-rebalancing-partitions)
9. [Ch 6 · Request Routing](./chapter-06-partitioning.md#4-request-routing)

### Transactions and isolation levels

1. [Ch 7 · The ACID Properties](./chapter-07-transactions.md#the-acid-properties)
2. [Ch 7 · Read Committed](./chapter-07-transactions.md#read-committed)
3. [Ch 7 · Snapshot Isolation](./chapter-07-transactions.md#snapshot-isolation-repeatable-read)
4. [Ch 7 · Lost Updates](./chapter-07-transactions.md#lost-updates)
5. [Ch 7 · Write Skew and Phantoms](./chapter-07-transactions.md#write-skew-and-phantoms)
6. [Ch 7 · Serializable Isolation](./chapter-07-transactions.md#serializable-isolation)
7. [Ch 7 · Two-Phase Commit](./chapter-07-transactions.md#two-phase-commit-2pc)

### From unreliable systems to consensus

1. [Ch 8 · Faults and Partial Failures](./chapter-08-distributed-systems-trouble.md#1-faults-and-partial-failures)
2. [Ch 8 · Unreliable Networks](./chapter-08-distributed-systems-trouble.md#2-unreliable-networks)
3. [Ch 8 · Unreliable Clocks](./chapter-08-distributed-systems-trouble.md#3-unreliable-clocks)
4. [Ch 8 · Process Pauses](./chapter-08-distributed-systems-trouble.md#process-pauses)
5. [Ch 8 · The Truth is Defined by the Majority](./chapter-08-distributed-systems-trouble.md#the-truth-is-defined-by-the-majority)
6. [Ch 9 · Linearizability](./chapter-09-consistency-consensus.md#2-linearizability)
7. [Ch 9 · The Cost of Linearizability](./chapter-09-consistency-consensus.md#the-cost-of-linearizability) (CAP)
8. [Ch 9 · Causality](./chapter-09-consistency-consensus.md#causality)
9. [Ch 9 · Total Order Broadcast](./chapter-09-consistency-consensus.md#total-order-broadcast)
10. [Ch 9 · Raft Consensus Algorithm](./chapter-09-consistency-consensus.md#raft-consensus-algorithm)
11. [Ch 9 · Apache ZooKeeper](./chapter-09-consistency-consensus.md#apache-zookeeper)

### Event-driven and streaming architectures

1. [Ch 4 · Modes of Dataflow](./chapter-04-encoding-evolution.md#5-modes-of-dataflow)
2. [Ch 11 · Message Brokers vs Event Logs](./chapter-11-stream-processing.md#message-brokers-vs-event-logs)
3. [Ch 11 · Apache Kafka Architecture](./chapter-11-stream-processing.md#apache-kafka-architecture)
4. [Ch 11 · Change Data Capture](./chapter-11-stream-processing.md#change-data-capture-cdc)
5. [Ch 11 · Event Sourcing](./chapter-11-stream-processing.md#event-sourcing)
6. [Ch 11 · Time in Stream Processing](./chapter-11-stream-processing.md#time-in-stream-processing)
7. [Ch 11 · Fault Tolerance](./chapter-11-stream-processing.md#5-fault-tolerance)
8. [Ch 12 · Data Integration](./chapter-12-future-data-systems.md#1-data-integration)
9. [Ch 12 · Derived Data](./chapter-12-future-data-systems.md#3-derived-data) (Lambda and Kappa)
10. [Ch 12 · End-to-End Argument for Data Systems](./chapter-12-future-data-systems.md#4-end-to-end-argument-for-data-systems)

### System design interview essentials

1. [Ch 1 · Describing Load](./chapter-01-reliable-scalable-maintainable.md#21-describing-load) and [Describing Performance](./chapter-01-reliable-scalable-maintainable.md#22-describing-performance)
2. [Ch 3 · B-Tree vs LSM-Tree](./chapter-03-storage-retrieval.md#b-tree-vs-lsm-tree)
3. [Ch 5 · Leaders and Followers](./chapter-05-replication.md#1-leaders-and-followers-single-leader-replication)
4. [Ch 5 · Problems with Replication Lag](./chapter-05-replication.md#3-problems-with-replication-lag)
5. [Ch 5 · Writing and Reading with Quorum](./chapter-05-replication.md#writing-and-reading-with-quorum)
6. [Ch 6 · Consistent Hashing](./chapter-06-partitioning.md#consistent-hashing)
7. [Ch 6 · Skewed Workloads and Hot Spots](./chapter-06-partitioning.md#skewed-workloads-and-hot-spots)
8. [Ch 7 · Isolation Levels](./chapter-07-transactions.md#isolation-levels)
9. [Ch 9 · The Cost of Linearizability](./chapter-09-consistency-consensus.md#the-cost-of-linearizability) (CAP)
10. [Ch 9 · Consensus Algorithms](./chapter-09-consistency-consensus.md#consensus-algorithms)
11. [Ch 11 · Apache Kafka Architecture](./chapter-11-stream-processing.md#apache-kafka-architecture)
12. [Ch 12 · Exactly-Once Semantics](./chapter-12-future-data-systems.md#exactly-once-semantics)

## Topics by theme

### Foundations

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| Faults vs failures | [Ch 1 · Reliability](./chapter-01-reliable-scalable-maintainable.md#1-reliability) | [Hardware Faults](./chapter-01-reliable-scalable-maintainable.md#11-hardware-faults), [Software Errors](./chapter-01-reliable-scalable-maintainable.md#12-software-errors), [Human Errors](./chapter-01-reliable-scalable-maintainable.md#13-human-errors) | — |
| Load parameters and fan-out | [Ch 1 · Describing Load](./chapter-01-reliable-scalable-maintainable.md#21-describing-load) | — | — |
| Latency percentiles (p99) | [Ch 1 · Describing Performance](./chapter-01-reliable-scalable-maintainable.md#22-describing-performance) | — | [Describing Load](./chapter-01-reliable-scalable-maintainable.md#21-describing-load) |
| Scaling up vs scaling out | [Ch 1 · Approaches for Coping with Load](./chapter-01-reliable-scalable-maintainable.md#23-approaches-for-coping-with-load) | [Ch 6 · Why Partition Data?](./chapter-06-partitioning.md#why-partition-data) | [Describing Load](./chapter-01-reliable-scalable-maintainable.md#21-describing-load) |
| Operability, simplicity, evolvability | [Ch 1 · Maintainability](./chapter-01-reliable-scalable-maintainable.md#3-maintainability) | [Ch 4 · Schema Evolution](./chapter-04-encoding-evolution.md#3-schema-evolution) | — |

### Data models and query languages

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| Relational vs document model | [Ch 2 · Relational Model vs Document Model](./chapter-02-data-models-query-languages.md#1-relational-model-vs-document-model) | [Comparison](./chapter-02-data-models-query-languages.md#comparison-relational-vs-document), [Choosing a Data Model](./chapter-02-data-models-query-languages.md#4-choosing-a-data-model) | — |
| One-to-many, many-to-many relationships | [Ch 2 · One-to-Many Relationships](./chapter-02-data-models-query-languages.md#one-to-many-relationships) | [Many-to-One and Many-to-Many](./chapter-02-data-models-query-languages.md#many-to-one-and-many-to-many-relationships) | [Relational vs Document](./chapter-02-data-models-query-languages.md#1-relational-model-vs-document-model) |
| Schema-on-read vs schema-on-write | [Ch 2 · Schema Flexibility](./chapter-02-data-models-query-languages.md#schema-flexibility) | [Ch 4 · Schema Evolution](./chapter-04-encoding-evolution.md#3-schema-evolution) | [Relational vs Document](./chapter-02-data-models-query-languages.md#1-relational-model-vs-document-model) |
| Data locality | [Ch 2 · Data Locality](./chapter-02-data-models-query-languages.md#data-locality) | — | [The Document Model](./chapter-02-data-models-query-languages.md#the-document-model) |
| Declarative vs imperative queries | [Ch 2 · Declarative vs Imperative](./chapter-02-data-models-query-languages.md#declarative-vs-imperative) | [Ch 10 · Declarative Query Languages](./chapter-10-batch-processing.md#declarative-query-languages) | — |
| MapReduce as a query model | [Ch 2 · MapReduce](./chapter-02-data-models-query-languages.md#mapreduce) | [Aggregation Pipeline](./chapter-02-data-models-query-languages.md#aggregation-pipeline), [Ch 10 · MapReduce Job Execution](./chapter-10-batch-processing.md#mapreduce-job-execution) | [Declarative vs Imperative](./chapter-02-data-models-query-languages.md#declarative-vs-imperative) |
| Graph data models | [Ch 2 · Graph Databases](./chapter-02-data-models-query-languages.md#3-graph-databases) | [Property Graphs](./chapter-02-data-models-query-languages.md#property-graphs), [Triple Stores](./chapter-02-data-models-query-languages.md#triple-stores), [When to Use Graph Databases](./chapter-02-data-models-query-languages.md#when-to-use-graph-databases) | — |

### Storage engines and indexes

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| Append-only logs and indexes | [Ch 3 · The Simplest Database](./chapter-03-storage-retrieval.md#the-simplest-database) | [Indexes](./chapter-03-storage-retrieval.md#indexes) | — |
| Hash indexes, compaction, segments | [Ch 3 · Hash Indexes](./chapter-03-storage-retrieval.md#2-hash-indexes) | [Compaction](./chapter-03-storage-retrieval.md#compaction), [Segmentation](./chapter-03-storage-retrieval.md#segmentation) | [The Simplest Database](./chapter-03-storage-retrieval.md#the-simplest-database) |
| SSTables and LSM-trees | [Ch 3 · SSTables and LSM-Trees](./chapter-03-storage-retrieval.md#3-sstables-and-lsm-trees) | [How to Create SSTables](./chapter-03-storage-retrieval.md#how-to-create-sstables), [Compaction Strategies](./chapter-03-storage-retrieval.md#compaction-strategies) | [Hash Indexes](./chapter-03-storage-retrieval.md#2-hash-indexes) |
| Bloom filters | [Ch 3 · LSM-Tree Read Path](./chapter-03-storage-retrieval.md#lsm-tree-read-path) | — | [SSTables and LSM-Trees](./chapter-03-storage-retrieval.md#3-sstables-and-lsm-trees) |
| B-trees | [Ch 3 · B-Trees](./chapter-03-storage-retrieval.md#4-b-trees) | [B-Tree Search](./chapter-03-storage-retrieval.md#b-tree-search), [B-Tree Insert](./chapter-03-storage-retrieval.md#b-tree-insert) | [Indexes](./chapter-03-storage-retrieval.md#indexes) |
| B-tree vs LSM-tree trade-offs | [Ch 3 · B-Tree vs LSM-Tree](./chapter-03-storage-retrieval.md#b-tree-vs-lsm-tree) | — | [SSTables and LSM-Trees](./chapter-03-storage-retrieval.md#3-sstables-and-lsm-trees), [B-Trees](./chapter-03-storage-retrieval.md#4-b-trees) |
| Write-ahead log (WAL) | [Ch 7 · How Durability Works](./chapter-07-transactions.md#how-durability-works) | [Ch 5 · WAL Shipping](./chapter-05-replication.md#write-ahead-log-wal-shipping) | — |
| Secondary, clustered, multi-column, full-text indexes | [Ch 3 · Other Indexing Structures](./chapter-03-storage-retrieval.md#5-other-indexing-structures) | [Ch 6 · Partitioning and Secondary Indexes](./chapter-06-partitioning.md#2-partitioning-and-secondary-indexes) | [Indexes](./chapter-03-storage-retrieval.md#indexes) |
| OLTP vs OLAP, data warehouses | [Ch 3 · Transaction Processing vs Analytics](./chapter-03-storage-retrieval.md#6-transaction-processing-vs-analytics) | [Data Warehousing](./chapter-03-storage-retrieval.md#data-warehousing), [Star Schema](./chapter-03-storage-retrieval.md#star-schema) | — |
| Column-oriented storage and compression | [Ch 3 · Column-Oriented Storage](./chapter-03-storage-retrieval.md#7-column-oriented-storage) | [Column Compression](./chapter-03-storage-retrieval.md#column-compression), [Sort Order in Columns](./chapter-03-storage-retrieval.md#sort-order-in-columns), [Writing to Column-Oriented Storage](./chapter-03-storage-retrieval.md#writing-to-column-oriented-storage) | [Transaction Processing vs Analytics](./chapter-03-storage-retrieval.md#6-transaction-processing-vs-analytics) |
| Materialized views and data cubes | [Ch 3 · Data Cubes and Materialized Views](./chapter-03-storage-retrieval.md#8-aggregation-data-cubes-and-materialized-views) | [Ch 12 · Derived Data](./chapter-12-future-data-systems.md#3-derived-data) | [Column-Oriented Storage](./chapter-03-storage-retrieval.md#7-column-oriented-storage) |

### Encoding and schema evolution

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| JSON, XML, CSV and their pitfalls | [Ch 4 · JSON, XML, and CSV](./chapter-04-encoding-evolution.md#json-xml-and-csv) | [Language-Specific Formats](./chapter-04-encoding-evolution.md#language-specific-formats) | — |
| Thrift and Protocol Buffers | [Ch 4 · Thrift and Protocol Buffers](./chapter-04-encoding-evolution.md#2-thrift-and-protocol-buffers) | [Binary Encoding](./chapter-04-encoding-evolution.md#binary-encoding) | [JSON, XML, and CSV](./chapter-04-encoding-evolution.md#json-xml-and-csv) |
| Backward and forward compatibility | [Ch 4 · Schema Evolution](./chapter-04-encoding-evolution.md#3-schema-evolution) | [Adding Fields](./chapter-04-encoding-evolution.md#adding-fields), [Removing Fields](./chapter-04-encoding-evolution.md#removing-fields), [Changing Field Types](./chapter-04-encoding-evolution.md#changing-field-types) | [Thrift and Protocol Buffers](./chapter-04-encoding-evolution.md#2-thrift-and-protocol-buffers) |
| Avro writer's and reader's schema | [Ch 4 · Avro](./chapter-04-encoding-evolution.md#4-avro) | [Writer's vs Reader's Schema](./chapter-04-encoding-evolution.md#writers-schema-vs-readers-schema), [Avro vs Thrift/Protocol Buffers](./chapter-04-encoding-evolution.md#avro-vs-thriftprotocol-buffers) | [Schema Evolution](./chapter-04-encoding-evolution.md#3-schema-evolution) |
| Dataflow through databases, REST/RPC, messaging | [Ch 4 · Modes of Dataflow](./chapter-04-encoding-evolution.md#5-modes-of-dataflow) | [Ch 11 · Message Brokers vs Event Logs](./chapter-11-stream-processing.md#message-brokers-vs-event-logs) | [Schema Evolution](./chapter-04-encoding-evolution.md#3-schema-evolution) |

### Replication

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| Single-leader replication | [Ch 5 · Leaders and Followers](./chapter-05-replication.md#1-leaders-and-followers-single-leader-replication) | [Why Replicate Data?](./chapter-05-replication.md#why-replicate-data), [Setting Up New Followers](./chapter-05-replication.md#setting-up-new-followers) | — |
| Synchronous vs asynchronous replication | [Ch 5 · Synchronous vs. Asynchronous Replication](./chapter-05-replication.md#synchronous-vs-asynchronous-replication) | — | [Leaders and Followers](./chapter-05-replication.md#1-leaders-and-followers-single-leader-replication) |
| Failover and its pitfalls | [Ch 5 · Leader Failure: Failover](./chapter-05-replication.md#leader-failure-failover) | [Ch 8 · Split Brain Problem](./chapter-08-distributed-systems-trouble.md#split-brain-problem), [Ch 9 · Leader Election](./chapter-09-consistency-consensus.md#leader-election) | [Leaders and Followers](./chapter-05-replication.md#1-leaders-and-followers-single-leader-replication) |
| Replication log formats | [Ch 5 · Replication Logs Implementation](./chapter-05-replication.md#2-replication-logs-implementation) | [Ch 11 · Change Data Capture](./chapter-11-stream-processing.md#change-data-capture-cdc) | [Leaders and Followers](./chapter-05-replication.md#1-leaders-and-followers-single-leader-replication) |
| Read-your-writes, monotonic reads, consistent prefix | [Ch 5 · Problems with Replication Lag](./chapter-05-replication.md#3-problems-with-replication-lag) | [Read-After-Write](./chapter-05-replication.md#read-after-write-consistency-read-your-writes-consistency), [Monotonic Reads](./chapter-05-replication.md#monotonic-reads), [Consistent Prefix Reads](./chapter-05-replication.md#consistent-prefix-reads), [Ch 9 · Spectrum of Consistency Models](./chapter-09-consistency-consensus.md#the-spectrum-of-consistency-models) | [Synchronous vs. Asynchronous](./chapter-05-replication.md#synchronous-vs-asynchronous-replication) |
| Multi-leader replication and write conflicts | [Ch 5 · Multi-Leader Replication](./chapter-05-replication.md#4-multi-leader-replication) | [Handling Write Conflicts](./chapter-05-replication.md#handling-write-conflicts), [Collaborative Editing](./chapter-05-replication.md#collaborative-editing-real-time-collaborative-applications) (OT, CRDTs) | [Leaders and Followers](./chapter-05-replication.md#1-leaders-and-followers-single-leader-replication) |
| Leaderless replication and quorums | [Ch 5 · Leaderless Replication](./chapter-05-replication.md#5-leaderless-replication) | [Writing and Reading with Quorum](./chapter-05-replication.md#writing-and-reading-with-quorum), [Quorum Consistency Limitations](./chapter-05-replication.md#quorum-consistency-limitations), [Sloppy Quorums and Hinted Handoff](./chapter-05-replication.md#sloppy-quorums-and-hinted-handoff) | [Problems with Replication Lag](./chapter-05-replication.md#3-problems-with-replication-lag) |
| Read repair and anti-entropy | [Ch 5 · Read Repair](./chapter-05-replication.md#read-repair) | [Anti-Entropy Process](./chapter-05-replication.md#anti-entropy-process) | [Leaderless Replication](./chapter-05-replication.md#5-leaderless-replication) |
| Concurrent writes, LWW, version vectors | [Ch 5 · Detecting Concurrent Writes](./chapter-05-replication.md#6-detecting-concurrent-writes) | [Last Write Wins](./chapter-05-replication.md#last-write-wins-lww), [Version Vectors](./chapter-05-replication.md#version-vectors), [Ch 9 · Capturing Causality with Version Vectors](./chapter-09-consistency-consensus.md#capturing-causality-with-version-vectors) | [Leaderless Replication](./chapter-05-replication.md#5-leaderless-replication) |

### Partitioning

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| What partitioning is | [Ch 6 · What is Partitioning?](./chapter-06-partitioning.md#what-is-partitioning) | [Partitioning vs. Replication](./chapter-06-partitioning.md#partitioning-vs-replication) | [Ch 5 · Leaders and Followers](./chapter-05-replication.md#1-leaders-and-followers-single-leader-replication) |
| Key-range vs hash partitioning | [Ch 6 · Partitioning of Key-Value Data](./chapter-06-partitioning.md#1-partitioning-of-key-value-data) | [By Key Range](./chapter-06-partitioning.md#partitioning-by-key-range), [By Hash of Key](./chapter-06-partitioning.md#partitioning-by-hash-of-key) | [What is Partitioning?](./chapter-06-partitioning.md#what-is-partitioning) |
| Consistent hashing | [Ch 6 · Consistent Hashing](./chapter-06-partitioning.md#consistent-hashing) | [Don't Hash Mod N](./chapter-06-partitioning.md#dont-hash-mod-n-bad-approach) | [Partitioning by Hash of Key](./chapter-06-partitioning.md#partitioning-by-hash-of-key) |
| Hot spots and skew | [Ch 6 · Skewed Workloads and Hot Spots](./chapter-06-partitioning.md#skewed-workloads-and-hot-spots) | [Ch 10 · Handling Skew](./chapter-10-batch-processing.md#handling-skew) | [Partitioning by Hash of Key](./chapter-06-partitioning.md#partitioning-by-hash-of-key) |
| Local vs global secondary indexes | [Ch 6 · Partitioning and Secondary Indexes](./chapter-06-partitioning.md#2-partitioning-and-secondary-indexes) | [Comparison: Local vs. Global](./chapter-06-partitioning.md#comparison-local-vs-global-indexes), [Ch 3 · Secondary Indexes](./chapter-03-storage-retrieval.md#secondary-indexes) | [Partitioning of Key-Value Data](./chapter-06-partitioning.md#1-partitioning-of-key-value-data) |
| Rebalancing strategies | [Ch 6 · Rebalancing Partitions](./chapter-06-partitioning.md#3-rebalancing-partitions) | [Comparison of Rebalancing Strategies](./chapter-06-partitioning.md#comparison-of-rebalancing-strategies), [Automatic vs. Manual](./chapter-06-partitioning.md#automatic-vs-manual-rebalancing) | [Partitioning of Key-Value Data](./chapter-06-partitioning.md#1-partitioning-of-key-value-data) |
| Request routing and gossip | [Ch 6 · Request Routing](./chapter-06-partitioning.md#4-request-routing) | [Coordination Service](./chapter-06-partitioning.md#approach-coordination-service-eg-zookeeper), [Gossip Protocol](./chapter-06-partitioning.md#approach-gossip-protocol), [Ch 9 · Service Discovery](./chapter-09-consistency-consensus.md#service-discovery) | [Rebalancing Partitions](./chapter-06-partitioning.md#3-rebalancing-partitions) |

### Transactions

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| What ACID means | [Ch 7 · The ACID Properties](./chapter-07-transactions.md#the-acid-properties) | [Atomicity](./chapter-07-transactions.md#1-atomicity), [Consistency](./chapter-07-transactions.md#2-consistency), [Isolation](./chapter-07-transactions.md#3-isolation), [Durability](./chapter-07-transactions.md#4-durability) | — |
| Abort and retry | [Ch 7 · Abort and Retry](./chapter-07-transactions.md#abort-and-retry) | [Ch 12 · Duplicate Suppression](./chapter-12-future-data-systems.md#duplicate-suppression) | [Atomicity](./chapter-07-transactions.md#1-atomicity) |
| Choosing an isolation level | [Ch 7 · Isolation Levels](./chapter-07-transactions.md#isolation-levels) | [Choosing an Isolation Level](./chapter-07-transactions.md#choosing-an-isolation-level), [Real-World Database Isolation](./chapter-07-transactions.md#real-world-database-isolation) | [Isolation](./chapter-07-transactions.md#3-isolation) |
| Read committed (dirty reads and writes) | [Ch 7 · Read Committed](./chapter-07-transactions.md#read-committed) | [No Dirty Reads](./chapter-07-transactions.md#no-dirty-reads), [No Dirty Writes](./chapter-07-transactions.md#no-dirty-writes) | [Isolation Levels](./chapter-07-transactions.md#isolation-levels) |
| Snapshot isolation and MVCC | [Ch 7 · Snapshot Isolation](./chapter-07-transactions.md#snapshot-isolation-repeatable-read) | [MVCC](./chapter-07-transactions.md#multi-version-concurrency-control-mvcc) | [Read Committed](./chapter-07-transactions.md#read-committed) |
| Lost updates | [Ch 7 · Lost Updates](./chapter-07-transactions.md#lost-updates) | [Solutions to Lost Updates](./chapter-07-transactions.md#solutions-to-lost-updates) | [Snapshot Isolation](./chapter-07-transactions.md#snapshot-isolation-repeatable-read) |
| Write skew and phantoms | [Ch 7 · Write Skew and Phantoms](./chapter-07-transactions.md#write-skew-and-phantoms) | [Solutions to Write Skew](./chapter-07-transactions.md#solutions-to-write-skew), [Ch 12 · Uniqueness Constraints](./chapter-12-future-data-systems.md#uniqueness-constraints) | [Lost Updates](./chapter-07-transactions.md#lost-updates) |
| Serial execution, 2PL, SSI | [Ch 7 · Serializable Isolation](./chapter-07-transactions.md#serializable-isolation) | [Actual Serial Execution](./chapter-07-transactions.md#actual-serial-execution), [Two-Phase Locking](./chapter-07-transactions.md#two-phase-locking-2pl), [SSI](./chapter-07-transactions.md#serializable-snapshot-isolation-ssi) | [Write Skew and Phantoms](./chapter-07-transactions.md#write-skew-and-phantoms) |
| Distributed transactions and 2PC | [Ch 7 · Distributed Transactions](./chapter-07-transactions.md#distributed-transactions) | [Two-Phase Commit](./chapter-07-transactions.md#two-phase-commit-2pc), [Ch 9 · Two-Phase Commit](./chapter-09-consistency-consensus.md#two-phase-commit-2pc), [Ch 9 · Three-Phase Commit](./chapter-09-consistency-consensus.md#three-phase-commit-3pc) | [Atomicity](./chapter-07-transactions.md#1-atomicity) |

### Faults, networks and clocks

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| Partial failures | [Ch 8 · Faults and Partial Failures](./chapter-08-distributed-systems-trouble.md#1-faults-and-partial-failures) | [Ch 1 · Reliability](./chapter-01-reliable-scalable-maintainable.md#1-reliability) | — |
| Unreliable networks and fault detection | [Ch 8 · Unreliable Networks](./chapter-08-distributed-systems-trouble.md#2-unreliable-networks) | [Detecting Faults](./chapter-08-distributed-systems-trouble.md#detecting-faults) | [Faults and Partial Failures](./chapter-08-distributed-systems-trouble.md#1-faults-and-partial-failures) |
| Timeouts and unbounded delays | [Ch 8 · Timeouts and Unbounded Delays](./chapter-08-distributed-systems-trouble.md#timeouts-and-unbounded-delays) | [Network Congestion and Queueing](./chapter-08-distributed-systems-trouble.md#network-congestion-and-queueing) | [Unreliable Networks](./chapter-08-distributed-systems-trouble.md#2-unreliable-networks) |
| Time-of-day vs monotonic clocks, NTP | [Ch 8 · Types of Clocks](./chapter-08-distributed-systems-trouble.md#types-of-clocks) | [Clock Synchronization](./chapter-08-distributed-systems-trouble.md#clock-synchronization) | — |
| Ordering events by timestamp | [Ch 8 · Timestamps for Ordering Events](./chapter-08-distributed-systems-trouble.md#timestamps-for-ordering-events) | [Relying on Synchronized Clocks](./chapter-08-distributed-systems-trouble.md#relying-on-synchronized-clocks), [Ch 5 · Last Write Wins](./chapter-05-replication.md#last-write-wins-lww) | [Types of Clocks](./chapter-08-distributed-systems-trouble.md#types-of-clocks) |
| Process pauses, leases, fencing tokens | [Ch 8 · Process Pauses](./chapter-08-distributed-systems-trouble.md#process-pauses) | [Fencing Tokens (Revisited)](./chapter-08-distributed-systems-trouble.md#fencing-tokens-revisited), [Ch 9 · Distributed Locks with ZooKeeper](./chapter-09-consistency-consensus.md#distributed-locks-with-zookeeper) | [Types of Clocks](./chapter-08-distributed-systems-trouble.md#types-of-clocks) |
| Majority quorums and split brain | [Ch 8 · The Truth is Defined by the Majority](./chapter-08-distributed-systems-trouble.md#the-truth-is-defined-by-the-majority) | [Split Brain Problem](./chapter-08-distributed-systems-trouble.md#split-brain-problem), [Ch 5 · Leader Failure: Failover](./chapter-05-replication.md#leader-failure-failover) | [Process Pauses](./chapter-08-distributed-systems-trouble.md#process-pauses) |
| Byzantine faults | [Ch 8 · Byzantine Faults](./chapter-08-distributed-systems-trouble.md#byzantine-faults) | [Weak Forms of Lying](./chapter-08-distributed-systems-trouble.md#weak-forms-of-lying) | [The Truth is Defined by the Majority](./chapter-08-distributed-systems-trouble.md#the-truth-is-defined-by-the-majority) |
| System models, safety and liveness | [Ch 8 · System Models](./chapter-08-distributed-systems-trouble.md#5-system-models) | [Timing Assumptions](./chapter-08-distributed-systems-trouble.md#timing-assumptions), [Node Failure Models](./chapter-08-distributed-systems-trouble.md#node-failure-models), [Algorithm Correctness](./chapter-08-distributed-systems-trouble.md#algorithm-correctness) | [Unreliable Networks](./chapter-08-distributed-systems-trouble.md#2-unreliable-networks) |

### Consistency, ordering and consensus

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| The spectrum of consistency models | [Ch 9 · Consistency Guarantees](./chapter-09-consistency-consensus.md#1-consistency-guarantees) | [Ch 5 · Problems with Replication Lag](./chapter-05-replication.md#3-problems-with-replication-lag) | — |
| Linearizability | [Ch 9 · Linearizability](./chapter-09-consistency-consensus.md#2-linearizability) | [Example: Non-Linearizable System](./chapter-09-consistency-consensus.md#example-non-linearizable-system), [Implementing Linearizability](./chapter-09-consistency-consensus.md#implementing-linearizability) | [Ch 5 · Problems with Replication Lag](./chapter-05-replication.md#3-problems-with-replication-lag) |
| Linearizability vs serializability | [Ch 9 · Linearizability vs. Serializability](./chapter-09-consistency-consensus.md#linearizability-vs-serializability) | — | [Linearizability](./chapter-09-consistency-consensus.md#2-linearizability), [Ch 7 · Serializable Isolation](./chapter-07-transactions.md#serializable-isolation) |
| CAP theorem | [Ch 9 · The Cost of Linearizability](./chapter-09-consistency-consensus.md#the-cost-of-linearizability) | — | [Linearizability](./chapter-09-consistency-consensus.md#2-linearizability) |
| Causality and happens-before | [Ch 9 · Causality](./chapter-09-consistency-consensus.md#causality) | [Happens-Before Relationship](./chapter-09-consistency-consensus.md#happens-before-relationship), [Version Vectors](./chapter-09-consistency-consensus.md#capturing-causality-with-version-vectors), [Ch 5 · Consistent Prefix Reads](./chapter-05-replication.md#consistent-prefix-reads) | — |
| Lamport timestamps | [Ch 9 · Sequence Numbers and Total Ordering](./chapter-09-consistency-consensus.md#sequence-numbers-and-total-ordering) | [Ch 8 · Timestamps for Ordering Events](./chapter-08-distributed-systems-trouble.md#timestamps-for-ordering-events) | [Causality](./chapter-09-consistency-consensus.md#causality) |
| Total order broadcast | [Ch 9 · Total Order Broadcast](./chapter-09-consistency-consensus.md#total-order-broadcast) | [Ch 7 · Consensus and Total Order Broadcast](./chapter-07-transactions.md#consensus-and-total-order-broadcast) | [Sequence Numbers and Total Ordering](./chapter-09-consistency-consensus.md#sequence-numbers-and-total-ordering) |
| Consensus and Raft | [Ch 9 · Consensus Algorithms](./chapter-09-consistency-consensus.md#consensus-algorithms) | [Raft](./chapter-09-consistency-consensus.md#raft-consensus-algorithm), [Consensus System Invariants](./chapter-09-consistency-consensus.md#consensus-system-invariants), [Performance Limitations](./chapter-09-consistency-consensus.md#consensus-performance-limitations) | [Total Order Broadcast](./chapter-09-consistency-consensus.md#total-order-broadcast), [Ch 8 · System Models](./chapter-08-distributed-systems-trouble.md#5-system-models) |
| FLP impossibility | [Ch 9 · The FLP Impossibility Result](./chapter-09-consistency-consensus.md#the-flp-impossibility-result) | — | [Ch 8 · Timing Assumptions](./chapter-08-distributed-systems-trouble.md#timing-assumptions) |
| ZooKeeper and coordination services | [Ch 9 · Membership and Coordination Services](./chapter-09-consistency-consensus.md#5-membership-and-coordination-services) | [ZooKeeper Data Model](./chapter-09-consistency-consensus.md#zookeeper-data-model), [Leader Election with ZooKeeper](./chapter-09-consistency-consensus.md#leader-election-with-zookeeper), [Alternatives to ZooKeeper](./chapter-09-consistency-consensus.md#alternatives-to-zookeeper) | [Consensus Algorithms](./chapter-09-consistency-consensus.md#consensus-algorithms) |
| Distributed locks | [Ch 9 · Distributed Locks with ZooKeeper](./chapter-09-consistency-consensus.md#distributed-locks-with-zookeeper) | [Ch 8 · Fencing Tokens (Revisited)](./chapter-08-distributed-systems-trouble.md#fencing-tokens-revisited) | [Ch 8 · Process Pauses](./chapter-08-distributed-systems-trouble.md#process-pauses) |

### Batch processing

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| The Unix philosophy | [Ch 10 · Batch Processing with Unix Tools](./chapter-10-batch-processing.md#1-batch-processing-with-unix-tools) | [The Unix Philosophy](./chapter-10-batch-processing.md#the-unix-philosophy), [The Unix Pipe](./chapter-10-batch-processing.md#the-unix-pipe) | — |
| Sorting vs in-memory aggregation | [Ch 10 · Sorting vs In-Memory Aggregation](./chapter-10-batch-processing.md#sorting-vs-in-memory-aggregation) | [Ch 3 · How to Create SSTables](./chapter-03-storage-retrieval.md#how-to-create-sstables) | [Simple Log Analysis](./chapter-10-batch-processing.md#simple-log-analysis) |
| MapReduce and HDFS | [Ch 10 · MapReduce and Distributed Filesystems](./chapter-10-batch-processing.md#2-mapreduce-and-distributed-filesystems) | [MapReduce Job Execution](./chapter-10-batch-processing.md#mapreduce-job-execution), [Distributed Filesystem](./chapter-10-batch-processing.md#distributed-filesystem), [MapReduce Workflows](./chapter-10-batch-processing.md#mapreduce-workflows) | [Batch Processing with Unix Tools](./chapter-10-batch-processing.md#1-batch-processing-with-unix-tools) |
| Joins and group-by in batch jobs | [Ch 10 · Joins in MapReduce](./chapter-10-batch-processing.md#joins-in-mapreduce) | [Group By in MapReduce](./chapter-10-batch-processing.md#group-by-in-mapreduce), [Handling Skew](./chapter-10-batch-processing.md#handling-skew) | [MapReduce Job Execution](./chapter-10-batch-processing.md#mapreduce-job-execution) |
| Dataflow engines (Spark) | [Ch 10 · Beyond MapReduce](./chapter-10-batch-processing.md#3-beyond-mapreduce) | [Dataflow Engines](./chapter-10-batch-processing.md#dataflow-engines), [Apache Spark](./chapter-10-batch-processing.md#apache-spark), [Materialization of Intermediate State](./chapter-10-batch-processing.md#materialization-of-intermediate-state) | [MapReduce Workflows](./chapter-10-batch-processing.md#mapreduce-workflows) |
| Fault tolerance in batch jobs | [Ch 10 · Fault Tolerance in Dataflow Engines](./chapter-10-batch-processing.md#fault-tolerance-in-dataflow-engines) | [Ch 11 · Fault Tolerance](./chapter-11-stream-processing.md#5-fault-tolerance) | [Dataflow Engines](./chapter-10-batch-processing.md#dataflow-engines) |
| Graph processing (Pregel, BSP) | [Ch 10 · Graph Processing](./chapter-10-batch-processing.md#4-graph-processing) | [Bulk Synchronous Parallel](./chapter-10-batch-processing.md#bulk-synchronous-parallel-bsp), [Graph Partitioning](./chapter-10-batch-processing.md#graph-partitioning), [Ch 2 · Graph Databases](./chapter-02-data-models-query-languages.md#3-graph-databases) | [MapReduce Job Execution](./chapter-10-batch-processing.md#mapreduce-job-execution) |
| Comparing batch systems | [Ch 10 · Comparing Batch Processing Systems](./chapter-10-batch-processing.md#5-comparing-batch-processing-systems) | [Declarative Query Languages](./chapter-10-batch-processing.md#declarative-query-languages) | [Beyond MapReduce](./chapter-10-batch-processing.md#3-beyond-mapreduce) |

### Stream processing

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| Message brokers vs event logs | [Ch 11 · Message Brokers vs Event Logs](./chapter-11-stream-processing.md#message-brokers-vs-event-logs) | [Ch 4 · Dataflow Through Message Passing](./chapter-04-encoding-evolution.md#dataflow-through-message-passing) | — |
| Kafka architecture | [Ch 11 · Apache Kafka Architecture](./chapter-11-stream-processing.md#apache-kafka-architecture) | — | [Message Brokers vs Event Logs](./chapter-11-stream-processing.md#message-brokers-vs-event-logs), [Ch 6 · Partitioning of Key-Value Data](./chapter-06-partitioning.md#1-partitioning-of-key-value-data) |
| Log compaction | [Ch 11 · Log Compaction](./chapter-11-stream-processing.md#log-compaction) | [Ch 3 · Compaction](./chapter-03-storage-retrieval.md#compaction) | [Apache Kafka Architecture](./chapter-11-stream-processing.md#apache-kafka-architecture) |
| Change data capture (CDC) | [Ch 11 · Change Data Capture](./chapter-11-stream-processing.md#change-data-capture-cdc) | [Ch 5 · Logical (Row-Based) Log Replication](./chapter-05-replication.md#logical-row-based-log-replication) | [Apache Kafka Architecture](./chapter-11-stream-processing.md#apache-kafka-architecture) |
| Event sourcing | [Ch 11 · Event Sourcing](./chapter-11-stream-processing.md#event-sourcing) | [Ch 12 · Designing Applications Around Dataflow](./chapter-12-future-data-systems.md#designing-applications-around-dataflow) | [Databases and Streams](./chapter-11-stream-processing.md#2-databases-and-streams) |
| Complex event processing and stream analytics | [Ch 11 · Processing Streams](./chapter-11-stream-processing.md#3-processing-streams) | [Complex Event Processing](./chapter-11-stream-processing.md#complex-event-processing), [Stream Analytics](./chapter-11-stream-processing.md#stream-analytics) | [Message Brokers vs Event Logs](./chapter-11-stream-processing.md#message-brokers-vs-event-logs) |
| Event time, windows, watermarks | [Ch 11 · Time in Stream Processing](./chapter-11-stream-processing.md#time-in-stream-processing) | [Ch 8 · Unreliable Clocks](./chapter-08-distributed-systems-trouble.md#3-unreliable-clocks) | [Stream Analytics](./chapter-11-stream-processing.md#stream-analytics) |
| Stream-stream, stream-table, table-table joins | [Ch 11 · Stream Joins](./chapter-11-stream-processing.md#4-stream-joins) | [Ch 10 · Joins in MapReduce](./chapter-10-batch-processing.md#joins-in-mapreduce) | [Time in Stream Processing](./chapter-11-stream-processing.md#time-in-stream-processing) |
| Microbatching, checkpointing, idempotence | [Ch 11 · Fault Tolerance](./chapter-11-stream-processing.md#5-fault-tolerance) | [Checkpointing](./chapter-11-stream-processing.md#checkpointing), [Idempotence](./chapter-11-stream-processing.md#idempotence), [Ch 12 · Exactly-Once Semantics](./chapter-12-future-data-systems.md#exactly-once-semantics) | [Processing Streams](./chapter-11-stream-processing.md#3-processing-streams) |
| Comparing stream frameworks | [Ch 11 · Stream Processing Frameworks Comparison](./chapter-11-stream-processing.md#6-stream-processing-frameworks-comparison) | — | [Fault Tolerance](./chapter-11-stream-processing.md#5-fault-tolerance) |

### Data integration and system design

| Topic | Start here | Also see | Read first |
|---|---|---|---|
| Single source of truth | [Ch 12 · Data Integration](./chapter-12-future-data-systems.md#1-data-integration) | [Better Approach: Single Source of Truth](./chapter-12-future-data-systems.md#better-approach-single-source-of-truth) | [Ch 11 · Change Data Capture](./chapter-11-stream-processing.md#change-data-capture-cdc) |
| Unbundling databases | [Ch 12 · Unbundling Databases](./chapter-12-future-data-systems.md#2-unbundling-databases) | [Composing Data Storage Technologies](./chapter-12-future-data-systems.md#composing-data-storage-technologies) | [Data Integration](./chapter-12-future-data-systems.md#1-data-integration) |
| CQRS | [Ch 12 · Designing Applications Around Dataflow](./chapter-12-future-data-systems.md#designing-applications-around-dataflow) | — | [Ch 11 · Event Sourcing](./chapter-11-stream-processing.md#event-sourcing) |
| Lambda vs Kappa architecture | [Ch 12 · Derived Data](./chapter-12-future-data-systems.md#3-derived-data) | [Lambda Architecture](./chapter-12-future-data-systems.md#lambda-architecture), [Kappa Architecture](./chapter-12-future-data-systems.md#kappa-architecture) | [Ch 10 · MapReduce Job Execution](./chapter-10-batch-processing.md#mapreduce-job-execution), [Ch 11 · Stream Analytics](./chapter-11-stream-processing.md#stream-analytics) |
| Exactly-once and idempotence end to end | [Ch 12 · End-to-End Argument](./chapter-12-future-data-systems.md#4-end-to-end-argument-for-data-systems) | [Exactly-Once Semantics](./chapter-12-future-data-systems.md#exactly-once-semantics), [Duplicate Suppression](./chapter-12-future-data-systems.md#duplicate-suppression), [Ch 11 · Idempotence](./chapter-11-stream-processing.md#idempotence) | [Ch 7 · Abort and Retry](./chapter-07-transactions.md#abort-and-retry) |
| Constraints without coordination | [Ch 12 · Enforcing Constraints](./chapter-12-future-data-systems.md#5-enforcing-constraints) | [Uniqueness Constraints](./chapter-12-future-data-systems.md#uniqueness-constraints), [Timeliness and Integrity](./chapter-12-future-data-systems.md#timeliness-and-integrity), [Coordination-Avoidance](./chapter-12-future-data-systems.md#coordination-avoidance) | [Ch 9 · Total Order Broadcast](./chapter-09-consistency-consensus.md#total-order-broadcast) |
| Auditing and verification | [Ch 12 · Trust, But Verify](./chapter-12-future-data-systems.md#6-trust-but-verify) | [Auditing](./chapter-12-future-data-systems.md#auditing), [Designing for Auditability](./chapter-12-future-data-systems.md#designing-for-auditability) | — |
| Privacy and ethics | [Ch 12 · Doing the Right Thing](./chapter-12-future-data-systems.md#7-doing-the-right-thing) | [Privacy and Data Protection](./chapter-12-future-data-systems.md#privacy-and-data-protection) | — |
