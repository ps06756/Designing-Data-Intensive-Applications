# Designing-Data-Intensive-Applications

This repository explains the concepts from "Designing Data-Intensive Applications" by Martin Kleppmann, with chapter-by-chapter breakdowns and practical examples.

## Chapters

- [Chapter 1: Reliable, Scalable, and Maintainable Applications](./chapter-1-reliable-scalable-maintainable.md) - Foundation chapter covering the three fundamental concerns in software systems: reliability (fault tolerance), scalability (handling growth), and maintainability (operability, simplicity, evolvability).

- [Chapter 2: Data Models and Query Languages](./chapter-2-data-models-query-languages.md) - Comprehensive exploration of data models including relational (SQL), document (NoSQL), and graph databases, along with their query languages, trade-offs, and when to use each model.

- [Chapter 3: Storage and Retrieval](./chapter-3-storage-retrieval.md) - Deep dive into how databases store and retrieve data, covering hash indexes, SSTables, LSM-trees, B-trees, and the differences between OLTP (row-oriented) and OLAP (column-oriented) storage engines.

- [Chapter 4: Encoding and Evolution](./chapter-4-encoding-evolution.md) - Comprehensive guide to data encoding formats (JSON, XML, Thrift, Protocol Buffers, Avro), schema evolution strategies, backward/forward compatibility, and dataflow patterns through databases, services, and message queues.

- [Chapter 5: Replication](./chapter-5-replication.md) - Explores replication strategies including single-leader, multi-leader, and leaderless replication, along with handling consistency challenges and conflicts.

- [Chapter 6: Partitioning](./chapter-6-partitioning.md) - Covers partitioning strategies (sharding) for scalability, including key-range and hash-based partitioning, secondary indexes, rebalancing techniques, and request routing approaches.

- [Chapter 7: Transactions](./chapter-7-transactions.md) - Deep dive into ACID properties, isolation levels (Read Committed, Snapshot Isolation, Serializable), concurrency control mechanisms (2PL, MVCC, SSI), and distributed transactions with two-phase commit.

- [Chapter 8: The Trouble with Distributed Systems](./chapter-8-distributed-systems-trouble.md) - Explores the fundamental challenges of distributed systems including unreliable networks, clock synchronization issues, process pauses, partial failures, Byzantine faults, and system models for reasoning about failures.

- [Chapter 9: Consistency and Consensus](./chapter-9-consistency-consensus.md) - Comprehensive coverage of consistency models (from eventual consistency to linearizability), ordering guarantees, causality, consensus algorithms (2PC, Paxos, Raft), and coordination services (ZooKeeper, etcd, Consul) for building fault-tolerant distributed systems.

- [Chapter 10: Batch Processing](./chapter-10-batch-processing.md) - In-depth exploration of batch processing systems from Unix tools to MapReduce and modern dataflow engines (Spark, Flink), covering distributed filesystems (HDFS), join algorithms, graph processing (Pregel model), fault tolerance strategies, and the evolution toward declarative SQL interfaces.

- [Chapter 11: Stream Processing](./chapter-11-stream-processing.md) - Comprehensive guide to stream processing covering event streams, message brokers (Kafka), change data capture (CDC), event sourcing, stream joins (stream-stream, stream-table), windowing operations, handling time and late events with watermarks, fault tolerance with exactly-once semantics, and comparison of stream processing frameworks.

- [Chapter 12: The Future of Data Systems](./chapter-12-future-data-systems.md) - Integrating everything together: data integration patterns, unbundling databases, derived data with Lambda and Kappa architectures, CQRS, end-to-end correctness with idempotence, enforcing constraints in distributed systems, trust and verification with audit logs, and ethical considerations for privacy and fairness in data systems design.