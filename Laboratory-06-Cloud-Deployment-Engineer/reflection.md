# 💭 Mission Reflection

---

## 📝 1. Compose File vs Typing Commands

Before this lab I would have started the database and the web app with two long docker run commands and hoped I remembered every flag. With the Compose file, all of that sat in one document that I could read, check with cat, and run again. When I ran docker-compose up -d, both containers came up together, and docker-compose down removed them just as easily.

---

## ⚠️ 2. Indentation Errors in YAML

I did not hit this problem in my own file, but I know YAML uses spaces to show which setting belongs to which service. A Tab or a wrong number of spaces can make the file fail to parse, or put a setting under the wrong service. That is why I printed the file with cat and ran docker-compose config before deploying.

---

## 🔑 3. Environment Variables

The variables let me pass the database name, user, and password to both containers without changing the images. The app and the database had to use the same values, or the login would fail. The password is only a lab value, and in a real deployment I would keep secrets outside the file.

---

## 🚀 4. Deploying Nextcloud in a Few Minutes

It felt quick once the file was right, but only after I fixed two problems. The docker compose command did not exist on the machine, so I used docker-compose. MariaDB 10.6 was past end of life, so I switched to 11.8. Seeing both containers show Up in docker-compose ps was satisfying, mostly because I had written the whole setup myself.

---

## 🌱 5. How My Understanding Has Evolved Since Mission 1

In Mission 1 the cloud felt like a set of services I clicked through. Now I see it as infrastructure I can describe in a file, deploy, check, and remove. I also learned to check that a lab's tools are still supported instead of trusting the instructions blindly.
