---
title: Send mail to whom not set as TO, CC, BCC via JavaMail
date: 2014-05-19 14:03 JST
tags:
---

# Send mail to whom not set as TO, CC, BCC via JavaMail

JavaMailで、`Message#setRecipients`されていないあて先にメールを送る方法。（JavaMailは1.4.4。最新版でも試してみないと。）

たぶんいろいろあるけど、`javax.mail.Session`を作成するときにプロパティとして `mail.smtp.from` として
SMTPコマンドを含んでいる文字列を渡すと、あて先に追加していないアドレスにメール送れたりする。

```java
  Properties properties = new Properties();
  // ~ 略
  properties.setProperty("mail.smtp.from", "from@localhost>\r\n" +
"RCPT TO: <to1@localhost>\r\n" +
"RCPT TO: <to2@localhost>\r\n" +
"DATA\r\n" +
"injected message\r\n" +
".\r\n");

  Session session = Session.getInstance(properties);
```

この`session`から、`MimeMessage`とかを作って`Transport#send`で送信すると、to1@localhostやto2@localhostに
華麗にメールが送信される。

```java
  MimeMessage message = new MimeMessage(session);
  // ~ 略
  Transport.send(message); // ここで、to1@localhostとかto2@localhostにメールが送信されちゃう。
```

SMTPサーバには、こんな感じのコマンドが送られちゃう。(`EHLO`とかは省略)

```
MAIL FROM:<return@localhost>
RCPT TO: <to1@localhost>
RCPT TO: <to2@localhost>
DATA
injected message
.
// ~ 略
```

この後に、実際に`Message`に設定されている情報が送られるんだけど、
SMTPサーバ側からしてみると`<CR><LF>.<CR><LF>`でコマンドが終わっちゃってるから、
そこまでの内容でメール送信しちゃうみたい。

要するに、 **`mail.smtp.from`とかにユーザ入力値を安易に入れちゃうとまずいんじゃなかろうか。**（メールの第三者中継的な？）

SMTPコマンドとしてそのまま実行されちゃうようなプロパティは、`mail.smtp.from`以外にもありそうな気がするし、
そもそも`Session`にわたすプロパティにユーザ入力値を使わないようにしたほうがいいのかな。
