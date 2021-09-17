import { Elm } from "/src/Main.elm";
import "/css/app.css";

const app = Elm.Main.init({
  node: document.getElementById("app"),
});

app.ports.changeTheme.subscribe((theme) => {
  if (theme === "") {
    document.body.classList.remove("dark");
  } else {
    document.body.classList.add(theme);
  }
});
