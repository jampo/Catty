/**
 *  Copyright (C) 2010-2019 The Catrobat Team
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

final class SetBrightnessBrickTests: AbstractBrickTests {

    func testSetBrightnessBrick() {
        let object = SpriteObject()
        let project = Project.defaultProject(withName: "a", projectID: "")
        let spriteNode = CBSpriteNode(spriteObject: object)
        object.spriteNode = spriteNode
        object.project = project

        let bundle = Bundle(for: SetBrightnessBrickTests.self)
        let filePath = bundle.path(forResource: "test.png", ofType: nil)
        let imageData: Data? = UIImage(contentsOfFile: filePath ?? "")!.pngData()
        let look = Look(name: "test", andPath: "test.png")
        try? imageData?.write(to: URL(fileURLWithPath: "\(object.projectPath()!)images/\("test.png")"), options: [.atomic])

        let script = WhenScript()
        script.object = object
        let brick = SetBrightnessBrick()
        brick.script = script
        object.lookList.add(look as Any)
        object.lookList.add(look as Any)
        object.spriteNode.currentLook = look
        object.spriteNode.currentUIImageLook = UIImage(contentsOfFile: filePath ?? "")

        brick.brightness = Formula(integer: 180)

        let action: () -> Void = brick.actionBlock(formulaInterpreter!)
        action()

        XCTAssertEqual(180.0, spriteNode.catrobatBrightness, accuracy: 0.1, "SetBrightnessBrick - Brightness not correct")
        Project.removeProjectFromDisk(withProjectName: project.header.programName, projectID: project.header.programID)
    }

    func testSetBrightnessBrickNegative() {
        let object = SpriteObject()
        let project = Project.defaultProject(withName: "a", projectID: "")
        let spriteNode = CBSpriteNode(spriteObject: object)
        object.spriteNode = spriteNode
        object.project = project

        let bundle = Bundle(for: SetBrightnessBrickTests.self)
        let filePath = bundle.path(forResource: "test.png", ofType: nil)
        let imageData: Data? = UIImage(contentsOfFile: filePath ?? "")!.pngData()
        let look = Look(name: "test", andPath: "test.png")
        try? imageData?.write(to: URL(fileURLWithPath: "\(object.projectPath()!)images/\("test.png")"), options: [.atomic])

        let script = WhenScript()
        script.object = object
        let brick = SetBrightnessBrick()
        brick.script = script
        object.lookList.add(look as Any)
        object.lookList.add(look as Any)
        object.spriteNode.currentLook = look
        object.spriteNode.currentUIImageLook = UIImage(contentsOfFile: filePath ?? "")

        brick.brightness = Formula(integer: -10)

        let action: () -> Void = brick.actionBlock(formulaInterpreter!)
        action()

        XCTAssertEqual(0.0, spriteNode.catrobatBrightness, accuracy: 0.1, "SetBrightnessBrick - Brightness not correct")
        Project.removeProjectFromDisk(withProjectName: project.header.programName, projectID: project.header.programID)
    }

    func testSetBrightnessBrickTooBright() {
        let object = SpriteObject()
        let project = Project.defaultProject(withName: "a", projectID: "")
        let spriteNode = CBSpriteNode(spriteObject: object)
        object.spriteNode = spriteNode
        object.project = project

        let bundle = Bundle(for: SetBrightnessBrickTests.self)
        let filePath = bundle.path(forResource: "test.png", ofType: nil)
        let imageData: Data? = UIImage(contentsOfFile: filePath ?? "")!.pngData()
        let look = Look(name: "test", andPath: "test.png")
        try? imageData?.write(to: URL(fileURLWithPath: "\(object.projectPath()!)images/\("test.png")"), options: [.atomic])

        let script = WhenScript()
        script.object = object

        let brick = SetBrightnessBrick()
        brick.script = script
        object.lookList.add(look as Any)
        object.lookList.add(look as Any)
        object.spriteNode.currentLook = look
        object.spriteNode.currentUIImageLook = UIImage(contentsOfFile: filePath ?? "")

        brick.brightness = Formula(integer: 210)

        let action: () -> Void = brick.actionBlock(formulaInterpreter!)
        action()

        XCTAssertEqual(200.0, spriteNode.catrobatBrightness, accuracy: 0.1, "SetBrightnessBrick - Brightness not correct")
        Project.removeProjectFromDisk(withProjectName: project.header.programName, projectID: project.header.programID)
    }

    func testSetBrightnessBrickWrongInput() {
        let object = SpriteObject()
        let project = Project.defaultProject(withName: "a", projectID: "")
        let spriteNode = CBSpriteNode(spriteObject: object)
        object.spriteNode = spriteNode
        object.project = project

        let bundle = Bundle(for: SetBrightnessBrickTests.self)
        let filePath = bundle.path(forResource: "test.png", ofType: nil)
        let imageData: Data? = UIImage(contentsOfFile: filePath ?? "")!.pngData()
        let look = Look(name: "test", andPath: "test.png")
        try? imageData?.write(to: URL(fileURLWithPath: "\(object.projectPath()!)images/\("test.png")"), options: [.atomic])

        let script = WhenScript()
        script.object = object

        let brick = SetBrightnessBrick()
        brick.script = script
        object.lookList.add(look as Any)
        object.lookList.add(look as Any)
        object.spriteNode.currentLook = look
        object.spriteNode.currentUIImageLook = UIImage(contentsOfFile: filePath ?? "")
        object.spriteNode.catrobatBrightness = 100.0

        brick.brightness = Formula(string: "a")

        let action: () -> Void = brick.actionBlock(formulaInterpreter!)
        action()

        XCTAssertEqual(0.0, spriteNode.catrobatBrightness, accuracy: 0.1, "SetBrightnessBrick - Brightness not correct")
        Project.removeProjectFromDisk(withProjectName: project.header.programName, projectID: project.header.programID)
    }
}
