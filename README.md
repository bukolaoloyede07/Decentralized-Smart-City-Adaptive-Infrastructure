# Decentralized Smart City Adaptive Infrastructure

A comprehensive blockchain-based system for managing and optimizing smart city infrastructure using Clarity smart contracts on the Stacks blockchain.

## Overview

This project implements a decentralized infrastructure management system that enables cities to:
- Verify and validate infrastructure systems
- Monitor real-time conditions and performance
- Plan and execute adaptive improvements
- Optimize resource allocation and efficiency
- Measure and improve system resilience

## Smart Contracts

### 1. Infrastructure Verification Contract (`infrastructure-verification.clar`)
Validates and certifies adaptive city systems.

**Key Features:**
- Register new infrastructure components
- Verify infrastructure integrity and compliance
- Track verification status and history
- Maintain verifier accountability

**Main Functions:**
- \`register-infrastructure\`: Add new infrastructure to the system
- \`verify-infrastructure\`: Mark infrastructure as verified
- \`get-infrastructure\`: Retrieve infrastructure details
- \`is-verified\`: Check verification status

### 2. Condition Monitoring Contract (`condition-monitoring.clar`)
Tracks infrastructure performance and environmental conditions.

**Key Features:**
- Real-time condition data collection
- Multi-parameter monitoring (temperature, humidity, pressure, vibration)
- Historical data tracking
- Status reporting and alerts

**Main Functions:**
- \`submit-reading\`: Record new condition measurements
- \`get-latest-reading\`: Retrieve most recent data
- \`get-reading\`: Access specific historical readings
- \`get-reading-count\`: Get total readings for infrastructure

### 3. Adaptation Planning Contract (`adaptation-planning.clar`)
Manages infrastructure evolution and improvement planning.

**Key Features:**
- Create and manage adaptation plans
- Priority-based planning system
- Cost estimation and timeline tracking
- Execution status monitoring

**Main Functions:**
- \`create-plan\`: Develop new adaptation strategies
- \`execute-plan\`: Implement approved plans
- \`get-plan\`: Retrieve plan details
- \`update-plan-status\`: Modify plan status

### 4. Resource Optimization Contract (`resource-optimization.clar`)
Maximizes infrastructure efficiency and resource utilization.

**Key Features:**
- Multi-resource allocation management
- Efficiency scoring and tracking
- Usage monitoring and optimization
- Cost reduction metrics

**Main Functions:**
- \`allocate-resource\`: Assign resources to infrastructure
- \`update-usage\`: Track resource consumption
- \`calculate-optimization\`: Compute efficiency scores
- \`get-allocation\`: View resource assignments

### 5. Resilience Measurement Contract (`resilience-measurement.clar`)
Evaluates and improves system adaptive capacity.

**Key Features:**
- Comprehensive resilience scoring
- Incident tracking and analysis
- Recovery time measurement
- Failure tolerance assessment

**Main Functions:**
- \`record-incident\`: Log system incidents
- \`resolve-incident\`: Mark incidents as resolved
- \`calculate-resilience\`: Compute resilience scores
- \`get-resilience-metrics\`: Access resilience data

## Architecture

The system follows a modular architecture where each contract handles a specific aspect of infrastructure management:

\`\`\`
┌─────────────────────┐    ┌─────────────────────┐
│ Infrastructure      │    │ Condition           │
│ Verification        │    │ Monitoring          │
└─────────────────────┘    └─────────────────────┘
│                           │
└─────────┬─────────────────┘
│
┌─────────────────────┐
│ Adaptation          │
│ Planning            │
└─────────────────────┘
│
┌─────────┴─────────┐
│                   │
┌─────────────────────┐    ┌─────────────────────┐
│ Resource            │    │ Resilience          │
│ Optimization        │    │ Measurement         │
└─────────────────────┘    └─────────────────────┘
\`\`\`

## Getting Started

### Prerequisites
- Stacks blockchain development environment
- Clarity CLI tools
- Node.js and npm for testing

### Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd smart-city-infrastructure
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Run tests:
   \`\`\`bash
   npm test
   \`\`\`

### Deployment

Deploy contracts to Stacks testnet:
\`\`\`bash
clarinet deploy --testnet
\`\`\`

## Usage Examples

### Registering Infrastructure
\`\`\`clarity
(contract-call? .infrastructure-verification register-infrastructure
"Smart Traffic Light"
"traffic-control"
"Main St & 1st Ave")
\`\`\`

### Monitoring Conditions
\`\`\`clarity
(contract-call? .condition-monitoring submit-reading
u1 ;; infrastructure-id
25 ;; temperature (°C)
u65 ;; humidity (%)
u1013 ;; pressure (hPa)
u2 ;; vibration level
"normal") ;; status
\`\`\`

### Creating Adaptation Plans
\`\`\`clarity
(contract-call? .adaptation-planning create-plan
u1 ;; infrastructure-id
"LED Upgrade"
"Replace traditional bulbs with smart LED system"
u3 ;; priority
u50000 ;; estimated cost
u30) ;; timeline (blocks)
\`\`\`

## Testing

The project includes comprehensive tests using Vitest. Run the test suite:

\`\`\`bash
npm test
\`\`\`

Tests cover:
- Contract deployment and initialization
- Function execution and error handling
- Data integrity and state management
- Integration between contracts

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For questions and support, please open an issue in the GitHub repository.

