# Expert System for Banking Loan Assistance in Common Lisp

## Project Overview

### Description
This project involves the realization of an expert system using Common Lisp, developed from September 2022 to February 2023 in association with the Université de Technologie de Compiègne (UTC). The expert system, designed at order 0+, supports decision-making in a banking system. It assesses loan conditions and determines loan feasibility. The project enhanced our understanding of expert systems and applied this knowledge to a practical case.

### Objective
The primary goal of the expert system is to address three key questions related to loans:
1. Is a loan feasible?
2. What will be the monthly repayment amount?
3. What will be the loan duration?

### Features
- **Loan Types Covered**: 
  - Mortgage
  - Student Loan
  - Consumer Credit
- **Decision Criteria**:
  - Loan feasibility based on user information
  - Monthly repayment calculation
  - Loan duration estimation

### Skills Acquired
- Common Lisp programming
- Expert system design and implementation
- Application of forward and backward chaining for inference

## Project Structure

### Base of Rules
The expert system's rule base was developed from expert sources including banking websites and loan simulators. The rules cover various aspects such as interest rates, loan amounts, duration, and eligibility criteria.

### Inference Engines
Three main functionalities are implemented using the inference engines:
1. **Feasibility Check**: Uses backward chaining to determine if a loan is feasible based on user-provided data.
2. **Monthly Repayment Calculation**: Uses forward chaining to compute the monthly repayment amount.
3. **Loan Duration Calculation**: Estimates the loan duration required based on the repayment amount.

## Implementation

### Dependencies
- [CLISP](https://clisp.sourceforge.io/): Common Lisp implementation used for this project.

### Authors

- Tobias Savary
-  Camille Bauvais

### University

Université de Technologie de Compiègne (UTC)

### Conclusion

This project successfully demonstrates the practical application of an expert system in the banking domain, providing valuable insights into loan feasibility, repayment calculations, and duration estimations. Through this project, we gained significant experience in both theoretical and practical aspects of expert system development using Common Lisp.

For more details, please refer to the project report included in this repository.

### License

This project is licensed under the MIT License - see the LICENSE file for details.
