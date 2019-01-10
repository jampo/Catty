/**
 *  Copyright (C) 2010-2018 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

import XCTest

@testable import Pocket_Code

final class RequiredResources: XCTestCase {

    func getProgramWithOneSprite(with brick: Brick?) -> Program? {
        let program = Program()
        let obj = SpriteObject()
        let script = Script()
        script.brickList.add(brick!)
        obj.scriptList.add(script)
        program.objectList.add(obj)

        return program
    }

    // MARK: - Look

    func testHideBrickResources() {
        let brick = HideBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses HideBrick not correctly calculated")
    }

    func testShowBrickResources() {
        let brick = ShowBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ShowBrick not correctly calculated")
    }

    func testSetTransparencyBrickResources() {
        let brick = SetTransparencyBrick()
        brick.transparency = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses SetTransparencyBrick not correctly calculated")
    }

    func testSetTransparencyBrick2Resources() {
        let brick = SetTransparencyBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: AccelerationXSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.transparency = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.deviceMotion,
                       "Resourses ShowBrick not correctly calculated")
    }

    func testSetSizeBrickResources() {
        let brick = SetSizeToBrick()
        brick.size = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses SetSizeToBrick not correctly calculated")
    }

    func testSetSizeBrick2Resources() {
        let brick = SetSizeToBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: AccelerationYSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.size = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.deviceMotion,
                       "Resourses SetSizeToBrick not correctly calculated")
    }

    func testSetBrightnessBrickResources() {
        let brick = SetBrightnessBrick()
        brick.brightness = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses SetBrightnessBrick not correctly calculated")
    }

    func testSetBrightnessBrick2Resources() {
        let brick = SetBrightnessBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: CompassDirectionSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.brightness = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.compass,
                       "Resourses SetBrightnessBrick not correctly calculated")
    }

    func testClearGraphicEffectBrickResources() {
        let brick = ClearGraphicEffectBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ClearGraphicEffectBrick not correctly calculated")
    }

    func testChangeTransparencyByNBrickResources() {
        let brick = ChangeTransparencyByNBrick()
        brick.changeTransparency = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ChangeTransparencyByNBrick not correctly calculated")
    }

    func testChangeTransparencyByNBrick2Resources() {
        let brick = ChangeTransparencyByNBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: InclinationXSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.changeTransparency = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.deviceMotion,
                       "Resourses ChangeTransparencyByNBrick not correctly calculated")
    }

    func testChangeBrightnessByNBrickResources() {
        let brick = ChangeBrightnessByNBrick()
        brick.changeBrightness = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ChangeBrightnessByNBrick not correctly calculated")
    }

    func testChangeBrightnessByNBrick2Resources() {
        let brick = ChangeBrightnessByNBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: InclinationXSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.changeBrightness = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.deviceMotion,
                       "Resourses ChangeBrightnessByNBrick not correctly calculated")
    }

    func testChangeColorByNBrickResources() {
        let brick = ChangeColorByNBrick()
        brick.changeColor = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ChangeBrightnessByNBrick not correctly calculated")
    }

    func testChangeColorByNBrick2Resources() {
        let brick = ChangeColorByNBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: InclinationYSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.changeColor = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.accelerometerAndDeviceMotion,
                       "Resourses ChangeBrightnessByNBrick not correctly calculated")
    }

    func testSetColorBrickResources() {
        let brick = SetColorBrick()
        brick.color = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses SetColorBrick not correctly calculated")
    }

    func testSetColorBrick2Resources() {
        let brick = SetColorBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: InclinationYSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.color = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.accelerometerAndDeviceMotion,
                       "Resourses SetColorBrick not correctly calculated")
    }

    // MARK: - Control

    func testWaitBrickResources() {
        let brick = WaitBrick()
        brick.timeToWaitInSeconds = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses WaitBrick not correctly calculated")
    }

    func testWaitBrick2Resources() {
        let brick = WaitBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: LoudnessSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.timeToWaitInSeconds = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.loudness,
                       "Resourses WaitBrick not correctly calculated")
    }

    func testRepeatBrickResources() {
        let brick = RepeatBrick()
        brick.timesToRepeat = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses RepeatBrick not correctly calculated")
    }

    func testRepeatBrick2Resources() {
        let brick = RepeatBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: LoudnessSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.timesToRepeat = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.loudness,
                       "Resourses RepeatBrick not correctly calculated")
    }

    func testNoteBrickResources() {
        let brick = NoteBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses NoteBrick not correctly calculated")
    }

    func testIfLogicBeginBrickResources() {
        let brick = IfLogicBeginBrick()
        brick.ifCondition = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses IfLogicBeginBrick not correctly calculated")
    }

    func testIfLogicBeginBrick2Resources() {
        let brick = IfLogicBeginBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: LoudnessSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.ifCondition = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.loudness,
                       "Resourses IfLogicBeginBrick not correctly calculated")
    }

    func testBroadcastBrickResources() {
        let brick = BroadcastBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses BroadcastBrick not correctly calculated")
    }

    // MARK: - Data

    func testSetVariableBrickResources() {
        let brick = SetVariableBrick()
        brick.variableFormula = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses SetVariableBrick not correctly calculated")
    }

    func testSetVariableBrick2Resources() {
        let brick = SetVariableBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: "FACE_DETECTED",
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.variableFormula = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.faceDetection,
                       "Resourses SetVariableBrick not correctly calculated")
    }

    func testChangeVariableBrickResources() {
        let brick = ChangeVariableBrick()
        brick.variableFormula = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ChangeVariableBrick not correctly calculated")
    }

    func testChangeVariableBrick2Resources() {
        let brick = ChangeVariableBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: LoudnessSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.variableFormula = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.loudness,
                       "Resourses ChangeVariableBrick not correctly calculated")
    }

    // MARK: - Sound

    func testStopAllSoundsBrickResources() {
        let brick = StopAllSoundsBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses StopAllSoundsBrick not correctly calculated")
    }

    func testSpeakBrickResources() {
        let brick = SpeakBrick()
        brick.text = "Hallo"
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.textToSpeech,
                       "Resourses SpeakBrick not correctly calculated")
    }

    func testSetVolumeToBrickResources() {
        let brick = SetVolumeToBrick()
        brick.volume = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses SetVolumeToBrick not correctly calculated")
    }

    func testSetVolumeToBrick2Resources() {
        let brick = SetVolumeToBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.volume = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses SetVolumeToBrick not correctly calculated")
    }

    func testChangeVolumeByNBrickResources() {
        let brick = ChangeVolumeByNBrick()
        brick.volume = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses SetVolumeToBrick not correctly calculated")
    }

    func testChangeVolumeByNBrick2Resources() {
        let brick = ChangeVolumeByNBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.volume = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses SetVolumeToBrick not correctly calculated")
    }

    // MARK: - IO

    func testVibrationBrickResources() {
        let brick = VibrationBrick()
        brick.durationInSeconds = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.vibration,
                       "Resourses VibrationBrick not correctly calculated")
    }

    func testLedOnBrickResources() {
        let brick = FlashBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses FlashBrick not correctly calculated")
    }

    // MARK: - Motion

    func testTurnRightBrickResources() {
        let brick = TurnRightBrick()
        brick.degrees = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses TurnRightBrick not correctly calculated")
    }

    func testTurnRightBrick2Resources() {
        let brick = TurnRightBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.degrees = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses TurnRightBrick not correctly calculated")
    }

    func testTurnLeftBrickResources() {
        let brick = TurnLeftBrick()
        brick.degrees = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses TurnLeftBrick not correctly calculated")
    }

    func testTurnLeftBrick2Resources() {
        let brick = TurnLeftBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.degrees = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses TurnLeftBrick not correctly calculated")
    }

    func testSetYBrickResources() {
        let brick = SetYBrick()
        brick.yPosition = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses SetYBrick not correctly calculated")
    }

    func testSetYBrick2Resources() {
        let brick = SetYBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.yPosition = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses SetYBrick not correctly calculated")
    }

    func testSetXBrickResources() {
        let brick = SetXBrick()
        brick.xPosition = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses SetXBrick not correctly calculated")
    }

    func testSetXBrick2Resources() {
        let brick = SetXBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.xPosition = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses SetXBrick not correctly calculated")
    }

    func testPointToBrickResources() {
        let brick = PointToBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses PointToBrick not correctly calculated")
    }

    func testPointInDirectionBrickResources() {
        let brick = PointInDirectionBrick()
        brick.degrees = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses PointInDirectionBrick not correctly calculated")
    }

    func testPointInDirectionBrick2Resources() {
        let brick = PointInDirectionBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.degrees = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses PointInDirectionBrick not correctly calculated")
    }

    func testPlaceAtBrickResources() {
        let brick = PlaceAtBrick()
        brick.xPosition = Formula(integer: 1)
        brick.yPosition = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses PlaceAtBrick not correctly calculated")
    }

    func testPlaceAtBrick2Resources() {
        let brick = PlaceAtBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.xPosition = Formula(formulaElement: element)

        brick.yPosition = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses PlaceAtBrick not correctly calculated")
    }

    func testMoveNStepsBrickResources() {
        let brick = MoveNStepsBrick()
        brick.steps = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses MoveNStepsBrick not correctly calculated")
    }

    func testMoveNStepsBrick2Resources() {
        let brick = MoveNStepsBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.steps = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses MoveNStepsBrick not correctly calculated")
    }

    func testIfOnEdgeBounceBrickResources() {
        let brick = IfOnEdgeBounceBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses IfOnEdgeBounceBrick not correctly calculated")
    }

    func testGoNStepsBackBrickResources() {
        let brick = GoNStepsBackBrick()
        brick.steps = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses GoNStepsBackBrick not correctly calculated")
    }

    func testGoNStepsBackBrick2Resources() {
        let brick = GoNStepsBackBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.steps = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses GoNStepsBackBrick not correctly calculated")
    }

    func testGlideToBrickResources() {
        let brick = GlideToBrick()
        brick.durationInSeconds = Formula(integer: 1)
        brick.xDestination = Formula(integer: 1)
        brick.yDestination = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses GlideToBrick not correctly calculated")
    }

    func testGlideToBrick2Resources() {
        let brick = GlideToBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.durationInSeconds = Formula(formulaElement: element)
        brick.xDestination = Formula(formulaElement: element)
        brick.yDestination = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses GlideToBrick not correctly calculated")
    }

    func testComeToFrontBrickResources() {
        let brick = ComeToFrontBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ComeToFrontBrick not correctly calculated")
    }

    func testChangeYByNBrickResources() {
        let brick = ChangeYByNBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.yMovement = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses ChangeYByNBrick not correctly calculated")
    }

    func testChangeYByNBrick2Resources() {
        let brick = ChangeYByNBrick()
        brick.yMovement = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ChangeYByNBrick not correctly calculated")
    }

    func testChangeXByNBrickResources() {
        let brick = ChangeXByNBrick()
        brick.xMovement = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ChangeXByNBrick not correctly calculated")
    }

    func testChangeXByNBrick2Resources() {
        let brick = ChangeXByNBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.xMovement = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses ChangeXByNBrick not correctly calculated")
    }

    func testChangeSizeByNBrickResources() {
        let brick = ChangeSizeByNBrick()
        brick.size = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.noResources,
                       "Resourses ChangeSizeByNBrick not correctly calculated")
    }

    func testChangeSizeByNBrick2Resources() {
        let brick = ChangeSizeByNBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroBottomLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.size = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses ChangeSizeByNBrick not correctly calculated")
    }

    // MARK: - Arduino

    func testArduinoSendDigitalValueBrickResources() {
        let brick = ArduinoSendDigitalValueBrick()
        brick.pin = Formula(integer: 1)
        brick.value = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothArduino,
                       "Resourses ArduinoSendDigitalValueBrick not correctly calculated")
    }

    func testArduinoSendPWMValueBrickResources() {
        let brick = ArduinoSendPWMValueBrick()
        brick.pin = Formula(integer: 1)
        brick.value = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothArduino,
                       "Resourses ArduinoSendPWMValueBrick not correctly calculated")
    }

    // MARK: - Phiro

    func testPhiroMotorMoveBackwardBrickResources() {
        let brick = PhiroMotorMoveBackwardBrick()
        brick.formula = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses PhiroMotorMoveBackwardBrick not correctly calculated")
    }

    func testPhiroMotorMoveForwardBrickResources() {
        let brick = PhiroMotorMoveForwardBrick()
        brick.formula = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses PhiroMotorMoveForwardBrick not correctly calculated")
    }

    func testPhiroMotorStopBrickResources() {
        let brick = PhiroMotorStopBrick()
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses PhiroMotorStopBrick not correctly calculated")
    }

    func testPhiroPlayToneBrickResources() {
        let brick = PhiroPlayToneBrick()
        brick.durationFormula = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses PhiroPlayToneBrick not correctly calculated")
    }

    func testPhiroRGBLightBrickResources() {
        let brick = PhiroRGBLightBrick()
        brick.redFormula = Formula(integer: 1)
        brick.greenFormula = Formula(integer: 1)
        brick.blueFormula = Formula(integer: 1)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(resources,
                       ResourceType.bluetoothPhiro,
                       "Resourses PhiroRGBLightBrick not correctly calculated")
    }

    // MARK: - NestedTests

    func testNestedResources() {
        let brick = GlideToBrick()
        var element = FormulaElement(elementType: ElementType.FUNCTION,
                                     value: ArduinoAnalogPinFunction.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.durationInSeconds = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationXSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick.xDestination = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: CompassDirectionSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick.yDestination = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(ResourceType.deviceMotion,
                       resources! & ResourceType.deviceMotion,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.compass,
                       resources! & ResourceType.compass,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.bluetoothArduino,
                       resources! & ResourceType.bluetoothArduino,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothPhiro,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.faceDetection,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.magnetometer,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.loudness,
                       "Resourses nested not correctly calculated")
    }

    func testNested2Resources() {
        let brick = GlideToBrick()
        var element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: "FACE_DETECTED",
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.durationInSeconds = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationYSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick.xDestination = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: LoudnessSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick.yDestination = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(ResourceType.loudness,
                       resources! & ResourceType.loudness,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.deviceMotion,
                       resources! & ResourceType.deviceMotion,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.faceDetection,
                       resources! & ResourceType.faceDetection,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothPhiro,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothArduino,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.magnetometer,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.compass,
                       "Resourses nested not correctly calculated")
    }

    func testNestedVibrationBrickResources() {
        let brick = VibrationBrick()
        let element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: LoudnessSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.durationInSeconds = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(ResourceType.vibration,
                       resources! & ResourceType.vibration,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.loudness,
                       resources! & ResourceType.loudness,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothPhiro,
                       "Resourses nested not correctly calculated")
    }

    func testNestedArduinoSendDigitalValueBrickResources() {
        let brick = ArduinoSendDigitalValueBrick()
        var element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: LoudnessSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.pin = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationYSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick.value = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(ResourceType.bluetoothArduino,
                       resources! & ResourceType.bluetoothArduino,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.deviceMotion,
                       resources! & ResourceType.deviceMotion,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.loudness,
                       resources! & ResourceType.loudness,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothPhiro,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.magnetometer,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.compass,
                       "Resourses nested not correctly calculated")
    }

    func testNestedArduinoSendPWMValueBrickResources() {
        let brick = ArduinoSendPWMValueBrick()
        var element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: LoudnessSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.pin = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationYSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick.value = Formula(formulaElement: element)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(ResourceType.bluetoothArduino,
                       resources! & ResourceType.bluetoothArduino,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.deviceMotion,
                       resources! & ResourceType.deviceMotion,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.loudness,
                       resources! & ResourceType.loudness,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothPhiro,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.magnetometer,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.compass,
                       "Resourses nested not correctly calculated")
    }

    // MARK: - MoreScripts

    func getProgramWithTwoScripts(withBricks brickArray: [Brick], andBrickArray2 brickArray2: [Brick]) -> Program? {
        let program = Program()
        let obj = SpriteObject()
        let script = Script()
        let script2 = Script()
        for brick: Brick in brickArray {
            script.brickList.add(brick)
        }
        for brick: Brick in brickArray2 {
            script2.brickList.add(brick)
        }
        obj.scriptList.add(script)
        obj.scriptList.add(script2)
        program.objectList.add(obj)

        return program
    }

    func testNestedResourcesTwoScripts() {
        let brick = PlaceAtBrick()
        var element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: ArduinoAnalogPinFunction.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.xPosition = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationXSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick.yPosition = Formula(formulaElement: element)
        let brick1 = GlideToBrick()
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: "FACE_DETECTED",
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.durationInSeconds = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationYSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.xDestination = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: LoudnessSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.yDestination = Formula(formulaElement: element)
        let brickArray = [brick, brick1]
        let brick2 = WaitBrick()
        brick2.timeToWaitInSeconds = Formula(integer: 1)
        let brick3 = HideBrick()
        let brick4 = ArduinoSendPWMValueBrick()
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: LoudnessSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick4.pin = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationYSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick4.value = Formula(formulaElement: element)
        let brickArray2 = [brick2, brick3, brick4]

        let prog: Program? = getProgramWithTwoScripts(withBricks: brickArray,
                                                      andBrickArray2: brickArray2)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(ResourceType.deviceMotion,
                       resources! & ResourceType.deviceMotion,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.loudness,
                       resources! & ResourceType.loudness,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.bluetoothArduino,
                       resources! & ResourceType.bluetoothArduino,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothPhiro,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.faceDetection,
                       resources! & ResourceType.faceDetection,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.magnetometer,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.compass,
                       "Resourses nested not correctly calculated")
    }

    func testNestedResourcesTwoScripts2() {
        let brick = SetXBrick()
        var element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: CompassDirectionSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.xPosition = Formula(formulaElement: element)
        let brick1 = GlideToBrick()
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationXSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.durationInSeconds = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationYSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.xDestination = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationZSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.yDestination = Formula(formulaElement: element)
        let brickArray = [brick, brick1]
        let brick2 = WaitBrick()
        brick2.timeToWaitInSeconds = Formula(integer: 1)
        let brick3 = HideBrick()

        let brick4 = ChangeTransparencyByNBrick()
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: LoudnessSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick4.changeTransparency = Formula(formulaElement: element)

        let brickArray2 = [brick2, brick3, brick4]

        let prog: Program? = getProgramWithTwoScripts(withBricks: brickArray,
                                                      andBrickArray2: brickArray2)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(ResourceType.deviceMotion,
                       resources! & ResourceType.deviceMotion,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.loudness,
                       resources! & ResourceType.loudness,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothArduino,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothPhiro,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.faceDetection,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.magnetometer,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.compass,
                       resources! & ResourceType.compass,
                       "Resourses nested not correctly calculated")
    }

    // MARK: - MoreSprites

    func getProgramWithTwoSprites(withBricks brickArray: [Brick],
                                  andBrickArray2 brickArray2: [Brick]) -> Program? {
        let program = Program()
        let obj = SpriteObject()
        let obj1 = SpriteObject()
        let script = Script()
        let script2 = Script()
        for brick: Brick in brickArray {
            script.brickList.add(brick)
        }
        for brick: Brick in brickArray2 {
            script2.brickList.add(brick)
        }
        obj.scriptList.add(script)
        obj1.scriptList.add(script2)
        program.objectList.add(obj)
        program.objectList.add(obj1)

        return program
    }

    func testNestedResourcesTwoSprites() {
        let brick = PlaceAtBrick()
        var element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: PhiroSideLeftSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.xPosition = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationXSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick.yPosition = Formula(formulaElement: element)
        let brick1 = GlideToBrick()
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: "FACE_DETECTED",
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.durationInSeconds = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationYSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.xDestination = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: LoudnessSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.yDestination = Formula(formulaElement: element)
        let brickArray = [brick, brick1]
        let brick2 = WaitBrick()
        brick2.timeToWaitInSeconds = Formula(integer: 1)
        let brick3 = HideBrick()
        let brick4 = ArduinoSendPWMValueBrick()
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: LoudnessSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick4.pin = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationYSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick4.value = Formula(formulaElement: element)
        let brickArray2 = [brick2, brick3, brick4]

        let prog: Program? = getProgramWithTwoSprites(withBricks: brickArray,
                                                      andBrickArray2: brickArray2)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(ResourceType.deviceMotion,
                       resources! & ResourceType.deviceMotion,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.loudness,
                       resources! & ResourceType.loudness,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.bluetoothArduino,
                       resources! & ResourceType.bluetoothArduino,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.bluetoothPhiro,
                       resources! & ResourceType.bluetoothPhiro,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.faceDetection,
                       resources! & ResourceType.faceDetection,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.magnetometer,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.compass,
                       "Resourses nested not correctly calculated")
    }

    func testNestedResourcesTwoSprites2() {
        let brick = SetXBrick()
        var element = FormulaElement(elementType: ElementType.SENSOR,
                                     value: CompassDirectionSensor.tag,
                                     leftChild: nil,
                                     rightChild: nil,
                                     parent: nil)
        brick.xPosition = Formula(formulaElement: element)
        let brick1 = GlideToBrick()
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationXSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.durationInSeconds = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationYSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.xDestination = Formula(formulaElement: element)
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: AccelerationZSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick1.yDestination = Formula(formulaElement: element)
        let brickArray = [brick, brick1]
        let brick2 = WaitBrick()
        brick2.timeToWaitInSeconds = Formula(integer: 1)
        let brick3 = HideBrick()

        let brick4 = ChangeTransparencyByNBrick()
        element = FormulaElement(elementType: ElementType.SENSOR,
                                 value: LoudnessSensor.tag,
                                 leftChild: nil,
                                 rightChild: nil,
                                 parent: nil)
        brick4.changeTransparency = Formula(formulaElement: element)

        let brickArray2 = [brick2, brick3, brick4]

        let prog: Program? = getProgramWithTwoSprites(withBricks: brickArray,
                                                      andBrickArray2: brickArray2)

        let resources = prog?.getRequiredResources()
        XCTAssertEqual(ResourceType.deviceMotion,
                       resources! & ResourceType.deviceMotion,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.loudness,
                       resources! & ResourceType.loudness,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothArduino,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.bluetoothPhiro,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.faceDetection,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(0,
                       resources! & ResourceType.magnetometer,
                       "Resourses nested not correctly calculated")
        XCTAssertEqual(ResourceType.compass,
                       resources! & ResourceType.compass,
                       "Resourses nested not correctly calculated")
    }

    // MARK: - Location

    func testLocationResources() {
        let formulaElement = FormulaElement(elementType: ElementType.SENSOR,
                                            value: LongitudeSensor.tag,
                                            leftChild: nil,
                                            rightChild: nil,
                                            parent: nil)

        let brick = ChangeSizeByNBrick()
        brick.size = Formula(formulaElement: formulaElement)
        let prog: Program? = getProgramWithOneSprite(with: brick)

        XCTAssertEqual(prog?.getRequiredResources(),
                       ResourceType.location,
                       "Resourses for Longitude not correctly calculated")

        formulaElement!.value = LatitudeSensor.tag
        XCTAssertEqual(prog?.getRequiredResources(),
                       ResourceType.location,
                       "Resourses for Latitude not correctly calculated")

        formulaElement!.value = AltitudeSensor.tag
        XCTAssertEqual(prog?.getRequiredResources(),
                       ResourceType.location,
                       "Resourses for Altitude not correctly calculated")

        formulaElement!.value = LocationAccuracySensor.tag
        XCTAssertEqual(prog?.getRequiredResources(),
                       ResourceType.location,
                       "Resourses for Location Accuracy not correctly calculated")

        brick.size = Formula()
        XCTAssertEqual(prog?.getRequiredResources(),
                       ResourceType.noResources,
                       "Resourses for Location not correctly calculated")
    }
}
