# Designing-Data-Intensive-Applications

This repository explains the concepts from "Designing Data-Intensive Applications" by Martin Kleppmann, with chapter-by-chapter breakdowns and practical examples.

## Chapters

- [Chapter 5: Replication](./chapter-5-replication.md) - Explores replication strategies including single-leader, multi-leader, and leaderless replication, along with handling consistency challenges and conflicts.

- [Chapter 6: Partitioning](./chapter-6-partitioning.md) - Covers partitioning strategies (sharding) for scalability, including key-range and hash-based partitioning, secondary indexes, rebalancing techniques, and request routing approaches.

- [Chapter 7: Transactions](./chapter-7-transactions.md) - Deep dive into ACID properties, isolation levels (Read Committed, Snapshot Isolation, Serializable), concurrency control mechanisms (2PL, MVCC, SSI), and distributed transactions with two-phase commit.

- [Chapter 8: The Trouble with Distributed Systems](./chapter-8-distributed-systems-trouble.md) - Explores the fundamental challenges of distributed systems including unreliable networks, clock synchronization issues, process pauses, partial failures, Byzantine faults, and system models for reasoning about failures.