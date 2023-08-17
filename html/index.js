var resourcename = GetParentResourceName();

$(()=>{
    const speed = $(".speed")
    const unit = $(".unit")
    const seatbelt = $(".seatbelt")
    const container = $(".carhud-container")
    window.addEventListener("message", (event) => {
        if (event.data.action === 'open') {
            notification(event.data)
        }
        if (event.data.showhud === true) {
            speed.fadeIn(0);
            speed.text(event.data.speed);
            unit.fadeIn(0);
            unit.text(event.data.unit);
            if (event.data.beltEnabled) {
                seatbelt.fadeIn(0);
                if (event.data.belt) {
                    seatbelt.removeClass("seatbelt-off")
                    seatbelt.addClass("seatbelt-on")
                } else {
                    seatbelt.removeClass("seatbelt-on")
                    seatbelt.addClass("seatbelt-off")
                }
            }
            container.fadeIn(0);
        } else if (event.data.showhud === false) {
            speed.fadeOut(1000);
            unit.fadeOut(1000);
            seatbelt.fadeOut(1000);
            container.fadeOut(1000);
        }
    })
})

function notification(data){

    let text = data.text.replaceAll("~INPUT_CONTEXT~","<kbd>E</kbd>")
    text = text.replaceAll("~s~","</span>&nbsp;")
    text = text.replaceAll("~g~","<span style='color:rgb(0, 128, 0)'>&nbsp;")
    text = text.replaceAll("~b~","<span style='color:rgb(0, 90, 255)'>&nbsp;")
    text = text.replaceAll("~r~","<span style='color:rgb(160, 0, 0)'>&nbsp;")
    text = text.replaceAll("~y~","<span style='color:yellow'>&nbsp;")
    text = text.replaceAll("~o~","<span style='color:orange'>&nbsp;")
    text = text.replaceAll("~pu~","<span style='color:rgb(169, 0, 211)'>&nbsp;")
    text = text.replaceAll("~pi~","<span style='color:pink'>&nbsp;")
    text = text.replaceAll("~d~","<span style='color:darkblue'>&nbsp;")

    data.duration ??= 3000;
    const notify = $(`<div class="notify ${data.type}">${text}</div>`)
    $("#notify-container").append(notify)
    notify.addClass("fade-in")
    notify.addClass(data.type)
    setTimeout(() => {
        notify.removeClass("fade-in")
        setTimeout(() => {
            notify.addClass("fade-out")
            setTimeout(() => {
                notify.remove()
            }, 800)
        }, data.duration)
    }, 800)

}
