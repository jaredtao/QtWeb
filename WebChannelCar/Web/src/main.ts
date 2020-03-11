import WebChannelCore from "./webchannelCore";
window.onload = () => {
    WebChannelCore.initialize(onInit, onUninit);
}
function onInit() {
    (window as any).document.getElementById("img").src = "../img/connected.svg";

    let car = WebChannelCore.SDK.car;

    let upBtn = (window as any).document.getElementById("up");
    let downBtn = (window as any).document.getElementById("down");
    let leftBtn = (window as any).document.getElementById("left");
    let rightBtn = (window as any).document.getElementById("right");

    let speedLabel = (window as any).document.getElementById("speed");
    let angleLabel = (window as any).document.getElementById("angle");

    upBtn.onclick = () => {
        car.accelerate();
    }
    downBtn.onclick = () => {
        car.decelerate();
    }
    leftBtn.onclick = () => {
        car.turnLeft();
    }
    rightBtn.onclick = () => {
        car.turnRight();
    }

    car.speedChanged.connect(onSpeedChanged);
    car.angleChanged.connect(onAngleChanged);
}
function onUninit() {
    (window as any).document.getElementById("img").src = "../img/disconnected.svg";
}

async function onSpeedChanged() {
    let speedLabel = (window as any).document.getElementById("speed");
    let car = WebChannelCore.SDK.car;
    
    speedLabel.textContent = await car.getSpeed();
}
async function onAngleChanged() {
    let angleLabel = (window as any).document.getElementById("angle");
    let car = WebChannelCore.SDK.car;

    angleLabel.textContent = await car.getAngle();
}
