# 3-Tier Infrastructure Deployment Using Terraform Modules

## 📝 Project Objective

The goal of this project is to design and deploy a **3-Tier Web Application Architecture** on **AWS** using **Terraform modules**. This architecture follows industry best practices for scalable and modular infrastructure.

---

## 🧱 Architecture Overview

This project is divided into three main tiers:

1. **Web Tier (Public Subnet)**
2. **Application Tier (Private Subnet)**
3. **Database Tier (Private Subnet with RDS)**

All resources are deployed using **Terraform modules**.

---

## 📐 Infrastructure Diagram

*Users  
│  
[Internet Gateway]  
│   
[EC2 Web Server (Nginx)] <------ Public Subnet (AZ1 & AZ2)  
│    
[EC2 App Server (PHP)] <------ Private Subnet (AZ1 & AZ2)  
│     
[Amazon RDS (MySQL)] <------ Private Subnet with DB Subnet Group*   
  
---  
   
## 🔧 Technologies Used

- **AWS Services**: VPC, EC2, RDS, Subnets, Route Tables, IGW, NAT Gateway, Security Groups
- **Infrastructure as Code**: Terraform (with modules)
- **Web Stack**: Nginx, PHP, HTML
- **Database**: Amazon RDS (MySQL/PostgreSQL)

---
   
## 📁 Project Structure
  
*3-tier-infra/       
├── modules/  
│ ├── vpc/   
│ ├── security/  
│ ├── web/   
│ ├── app/    
│ └── db/           
├── main.tf              
├── variables.tf              
├── terraform.tfvars        
└── README.md*          
                      
---                  
                         
## 🛠️ Prerequisites           

- AWS account with IAM user having sufficient permissions
- AWS CLI configured (`aws configure`)
- Terraform installed (`terraform -version`)
- SSH Key Pair (for EC2 access)
- Git installed

---

## 🚀 Deployment Steps

### Step 1: Clone the Repository

```bash
git clone https://github.com/nileshrajure741075/3-Tier-Infrastructure-Deployment-Using-Terraform-.git
cd 3-Tier-Infrastructure-Deployment-Using-Terraform-
