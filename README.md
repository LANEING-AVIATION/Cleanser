# Cleanser: The Dawn of LANEING AVIATION's Learning Space

Welcome to **Cleanser**, a repository that marks the inception of LANEING AVIATION's ambitious journey in programming and beyond. Since September 2023, we've been meticulously preparing for this moment, and on September 2, 2024, we finally embarked on our first Cleanser cycle. This fall, we dive into the depths of ACM/ICPC programming, laying the foundation for future technological advancements.

## Project Overview

**Cleanser** is more than just a project; it's a pursuit of coding excellence, democracy, and peace. Our first phase revolves around structured learning and hands-on programming sessions.

### Toolchain

**Cx Studio**

**VMware + Pixhawk SITL + Teamviewer**

**VMware + MATLAB + Teamviewer**

**MATLAB Online + MATLAB Mobile**

**WSL + VSCode Tunnel**


### Update Sept 13th

Over the past few weeks, this project has made substantial progress. Currently, our work encompasses four key components: C++ Algorithm ACM Development, Flight Control Simulation, MATLAB Mathematical Modeling, and Classroom Notes. The first three are particularly meaningful extracurricular activities. I will soon dive deeper into MATLAB programming as the next phase of my journey.

C++ programming was abandoned after the first class. It was initially something I had long committed to, and I hoped to improve in that area. However, it turned out to be rather dull and failed to spark my interest. What I truly enjoy often requires a vast number of dependencies and a complex toolchain, something the monotonous nature of C++ algorithm development simply can't offer. In my opinion, the best learning approach is fragmented and dynamic, not obsessing over a single task. Of course, this doesn't mean jumping between topics without focus.

Flight control simulation, on the other hand, has been a highly rewarding activity, with significant progress—I've completed over 300 flight tests. But now, I've hit a bottleneck. The virtual machine I'm using struggles to leverage GPU resources directly, which causes severe strain on system resources during simulations, sometimes even breaking the connection. The environment setup is also quite complicated, involving communication between various programs, including those outside of Windows or within a WSL backend. This exacerbates the resource issue even further. I use Power Automate to maintain my campus network login, but to my surprise, even this automation script consumes a considerable amount of CPU and memory. 

At some point, I hope to return to the drone control domain, but for now, it's time for a change of pace. MATLAB, by contrast, is proving to be quite enjoyable. I've explored MATLAB in various forms—on a Windows PC, on Android, through the Web version, and even via remote desktop access. However, I've found that the Windows version takes up too much storage space, which isn't ideal. The Android version is little more than a command line interface, which I found quite uninspiring. The Web version, while convenient, suffers from occasional lag and presents challenges with file management—particularly with Git integration. I had to construct a convoluted solution to sync OneDrive with my Git repository, which became tedious.

Now, I seem to have found a better approach. I’ve installed all MATLAB functionalities on my Ubuntu virtual machine, the same one I use for drone simulations (which also hosts my repository), and I access it via remote desktop. I think this is a solid choice, and it's probably time to uninstall the Windows version since I don’t foresee needing it for the moment. I'll focus on working through some MATLAB textbooks for now. That should keep me occupied for a good while.

So far, my three major extracurricular achievements this term have been: ACM programming, drone simulations, and MATLAB learning. I believe accomplishing 4-6 areas by the end of this term would be quite satisfactory.

### Schedule

- **Programming Days:** Every Monday and Wednesday
- **Session Duration:** Four periods per day, each lasting 45 minutes

The journey started with high hopes but faced immediate challenges. On the first day, we encountered the limitations of our initial setup: Android tablets running AOSP12 struggled with the demands of C++ programming, rendering the experience both frustrating and uninspiring. However, we turned this setback into a learning opportunity—a warm-up for what was to come.

### Strategic Adjustments

Recognizing the need for more robust hardware, we pivoted to using a high-performance Windows laptop stationed in a cool, air-conditioned room. The laptop runs VMware with an Ubuntu 20.04 virtual machine configured with ROS Noetic, connected via TeamViewer. By using a Bluetooth keyboard and mouse with the tablet, we remotely accessed the virtual environment to maintain a stable and productive workflow.

This setup, while functional, is not without its flaws. The virtual machine's performance lags behind our expectations, and the streaming experience can be choppy, reducing efficiency. However, this is a work in progress, and I am optimistic about making improvements as we move forward.

### Cleanser's Purpose

The Cleanser project aims to build a solid foundation in ROS, equipping us with the knowledge necessary for developing LANEING AVIATION's future UAV control solutions—specifically, the **Anniecopter**. This project is a stepping stone towards achieving our broader vision of integrating cutting-edge technology into autonomous flight systems.

### Looking Ahead

As of September 2, the initial ACM programs have been successfully uploaded to the repository. I plan to continue updating the repository with content from each programming session, though this may not strictly follow a set schedule. Each update brings us closer to mastering the tools and skills necessary for our ambitious goals.

Wish me luck as I continue to navigate this journey of discovery and innovation!

---

![The Cleanser Project](https://github.com/LANEING-AVIATION/Cleanser/blob/main/Homepage/init.jpg)
