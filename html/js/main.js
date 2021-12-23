const playMusic = (name, url) => {
  const volume = document.getElementById("volume").value / 100;
  console.log(volume);
  fetch("https://esx_radio/playMusic", {
    method: "POST",
    headers: {
      "Content-Type": "application/json; charset=UTF-8",
    },
    body: JSON.stringify({ name, url, volume }),
  }).then((resp) => resp.json());

  const main = document.getElementById("main");
  main.style.display = "none";
};

const showMusic = () => {
  const addMusicModal = document.getElementById("music-modal");
  if (addMusicModal) {
    addMusicModal.style.display = "block";
  }
};

const addMusic = () => {
  const addMusicModal = document.getElementById("music-modal");
  if (addMusicModal) {
    const musicName = document.getElementById("name");
    const musicUrl = document.getElementById("url");

    if (musicName && musicUrl) {
      fetch("https://esx_radio/newMusic", {
        method: "POST",
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
        body: JSON.stringify({ name: musicName.value, url: musicUrl.value }),
      }).then((resp) => resp.json());
    }
    addMusicModal.style.display = "none";
  }
};

// slider / 10000

window.addEventListener("keyup", (event) => {
  if (event.key === "Escape") {
    fetch("https://esx_radio/close", {
      method: "POST",
    }).then((resp) => resp.json());
    const main = document.getElementById("main");
    main.style.display = "none";
  }
});

window.addEventListener("message", (event) => {
  const { type, music } = event.data;

  if (type === "show" && music) {
    const main = document.getElementById("main");
    if (main) {
      main.style.display = "block";

      const musicList = document.getElementById("music-list");
      if (musicList) {
        musicList.innerHTML = "";
        Object.entries(music).forEach(([_, music]) => {
          const element = document.createElement("div");
          element.classList = "w-20 h-20 flex items-center flex-col";

          element.innerHTML = `
            <div class="max-w-xs flex flex-col space-y-3 items-center p-4 px-7 border rounded-md border-gray-600 w-max h-max">
              <button onclick="playMusic('${music.name}', '${music.url}')">
                <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M14.752 11.168l-3.197-2.132A1 1 0 0010 9.87v4.263a1 1 0 001.555.832l3.197-2.132a1 1 0 000-1.664z" />
                  <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                </svg>
              </button>
              <span>${music.name}</span>
            </div>`;
          // Truncate ^^^^^^^

          musicList.appendChild(element);
        });
        const elementAdd = document.createElement("div");
        elementAdd.classList = "w-20 h-20 flex items-center flex-col";

        elementAdd.innerHTML = `
          <div class="max-w-xs flex flex-col space-y-3 items-center p-4 px-7 border rounded-md border-gray-600 w-max h-max">
            <button onclick="showMusic()">
              <svg class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4v16m8-8H4" />
              </svg>
            </button>
          </div>`;

        musicList.appendChild(elementAdd);
      }
    }
  }
});
