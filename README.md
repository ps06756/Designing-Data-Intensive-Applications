# Designing Data-Intensive Applications (2nd Edition)

This repository explains the concepts from "Designing Data-Intensive Applications" by Martin Kleppmann (with Chris Riccomini), with chapter-by-chapter breakdowns and practical examples. Notes track the **2nd edition**.

## Chapters

- [Chapter 1: Trade-Offs in Data Systems Architecture](./chapter-01-tradeoffs-data-systems.md) - Frames the foundational choices in data systems: operational vs analytical (OLTP vs OLAP), data warehousing vs data lakes, systems of record vs derived data, cloud vs self-hosting, cloud-native architecture (separation of storage/compute, object stores), and distributed vs single-node systems.

- [Chapter 2: Defining Nonfunctional Requirements](./chapter-02-nonfunctional-requirements.md) - Case study of a social network home timelines to ground reliability, scalability, and maintainability in concrete numbers; covers latency vs response time vs throughput, percentiles (p50/p95/p99/p999), SLOs/SLAs, tail latency amplification, shared-memory/shared-disk/shared-nothing architectures, and metastable failures.

- [Chapter 3: Data Models and Query Languages](./chapter-03-data-models-query-languages.md) - Relational vs document models, normalization vs denormalization, many-to-many relationships, analytics schemas (star, snowflake), graph models (property graphs, Cypher, SPARQL, Datalog), GraphQL, event sourcing and CQRS, plus DataFrames for ML workloads.

- [Chapter 4: Storage and Retrieval](./chapter-04-storage-retrieval.md) - Log-structured storage (LSM-trees) and B-trees for OLTP, multicolumn/secondary indexes, column-oriented storage for analytics, cloud data warehouses, compilation vs vectorization, materialized views, full-text search, and vector embeddings for similarity/ML search.

- [Chapter 5: Encoding and Evolution](./chapter-05-encoding-evolution.md) - Encoding formats (JSON, XML, Protobuf, Avro, Thrift), the merits of schemas, and four modes of dataflow: through databases, through services (REST/RPC), through durable execution/workflows (Temporal, Cadence), and through event-driven architectures. Backward/forward compatibility for schema evolution.

- [Chapter 6: Replication](./chapter-06-replication.md) - Single-leader replication (sync/async, failover, replication logs), replication lag problems (read-your-writes, monotonic reads), multi-leader topologies and conflict resolution (LWW, CRDTs), leaderless replication with quorums, multi-region operation, and detecting concurrent writes via version vectors.

- [Chapter 7: Sharding](./chapter-07-sharding.md) - Why shard, sharding by key range vs hash of key, skewed workloads and hot-spot mitigation (random suffixes, virtual nodes), automatic vs manual rebalancing, request routing, and local vs global secondary indexes.

- [Chapter 8: Transactions](./chapter-08-transactions.md) - ACID semantics, single-object vs multi-object operations, weak isolation levels (Read Committed, Snapshot Isolation, write skew, phantoms), serializability via serial execution, 2PL, or SSI, distributed transactions with two-phase commit, and exactly-once message processing.

- [Chapter 9: The Trouble with Distributed Systems](./chapter-09-distributed-systems-trouble.md) - Unreliable networks and the limits of TCP, timeouts and unbounded delays, monotonic vs time-of-day clocks and clock synchronization (NTP, GPS, Spanner TrueTime), process pauses, distributed locks and leases (Redlock critique), Byzantine faults, system models, and formal verification (TLA+, Jepsen).

- [Chapter 10: Consistency and Consensus](./chapter-10-consistency-consensus.md) - Linearizability, ordering guarantees, Lamport clocks, vector clocks, linearizable ID generators (Snowflake), consensus algorithms (Paxos, Raft), total order broadcast, and coordination services (ZooKeeper, etcd, Consul).

- [Chapter 11: Batch Processing](./chapter-11-batch-processing.md) - Unix tools as the original batch processor, distributed filesystems (HDFS) and object stores (S3), MapReduce, Dataflow engines (Spark, Flink, Beam), shuffling strategies, join algorithms (sort-merge, broadcast hash), SQL-on-Hadoop, and use cases (ETL, analytics, ML, serving).

- [Chapter 12: Stream Processing](./chapter-12-stream-processing.md) - Transmitting event streams (messaging systems vs log-based brokers like Kafka), Change Data Capture (CDC), event sourcing, stream joins (stream-stream, stream-table), windowing and watermarks for time, and exactly-once fault tolerance.

- [Chapter 13: A Philosophy of Streaming Systems](./chapter-13-philosophy-streaming-systems.md) - Data integration via derived data, batch/stream unification, unbundling databases, designing applications around dataflow, observing derived state, the end-to-end argument, enforcing cross-system constraints, timeliness vs integrity, and self-auditing systems.

- [Chapter 14: Doing the Right Thing](./chapter-14-doing-the-right-thing.md) - Ethical responsibilities in data systems: bias and discrimination in predictive analytics, feedback loops, privacy and tracking, consent, GDPR/CCPA implications, data as power, and the parallels to Industrial-Revolution-era regulation.

## Source

The 2nd edition PDF lives at `~/Downloads/designing-data-intensive-applications-the-big-ideas-behind-reliable-scalable-and-maintainable-systems-2_compress.pdf`.
