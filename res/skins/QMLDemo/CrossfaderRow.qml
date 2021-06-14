import "." as Skin
import Mixxx 0.1 as Mixxx
import QtQuick 2.12
import QtQuick.Controls 2.12
import "Theme"

Item {
    id: root

    property real crossfaderWidth // required

    implicitHeight: crossfader.height

    Skin.SectionBackground {
        anchors.fill: microphoneRow
    }

    Row {
        id: microphoneRow

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: crossfader.left
        layoutDirection: Qt.RightToLeft
        padding: 5
        spacing: 10

        Skin.MicrophoneUnit {
            unitNumber: 1
        }

        Skin.MicrophoneUnit {
            unitNumber: 2
        }

        Skin.MicrophoneUnit {
            unitNumber: 3
        }

        Skin.MicrophoneUnit {
            unitNumber: 4
        }

        Column {
            Skin.ControlSlider {
                width: 50
                height: 26
                orientation: Qt.Horizontal
                group: "[Master]"
                key: "duckStrength"
                barColor: Theme.crossfaderBarColor
                barStart: 1
                fg: Theme.imgMicDuckingSliderHandle
                bg: Theme.imgMicDuckingSlider
            }

            Skin.Button {
                id: pflButton

                text: {
                    switch (duckingControl.value) {
                    case 1:
                        return "Auto";
                    case 2:
                        return "Manual";
                    default:
                        return "Off";
                    }
                }
                activeColor: Theme.pflActiveButtonColor
                highlight: {
                    let value = duckingControl.value;
                    return (value == 1 || value == 2);
                }
                onClicked: duckingControl.value = (duckingControl.value + 1) % 3

                Mixxx.ControlProxy {
                    id: duckingControl

                    group: "[Master]"
                    key: "talkoverDucking"
                }

            }

        }

    }

    Skin.SectionBackground {
        id: crossfader

        anchors.centerIn: parent
        width: root.crossfaderWidth
        height: crossfaderSlider.height + 20

        Skin.ControlSlider {
            id: crossfaderSlider

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            orientation: Qt.Horizontal
            group: "[Master]"
            key: "crossfader"
            barColor: Theme.crossfaderBarColor
            barStart: 0.5
            fg: Theme.imgCrossfaderHandle
            bg: Theme.imgCrossfaderBackground
        }

    }

    Row {
        id: auxiliaryRow

        anchors.left: crossfader.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        padding: 5
        spacing: 10

        Skin.AuxiliaryUnit {
            layoutDirection: Qt.RightToLeft
            unitNumber: 1
        }

        Skin.AuxiliaryUnit {
            layoutDirection: Qt.RightToLeft
            unitNumber: 2
        }

        Skin.AuxiliaryUnit {
            layoutDirection: Qt.RightToLeft
            unitNumber: 3
        }

        Skin.AuxiliaryUnit {
            layoutDirection: Qt.RightToLeft
            unitNumber: 4
        }

    }

}
