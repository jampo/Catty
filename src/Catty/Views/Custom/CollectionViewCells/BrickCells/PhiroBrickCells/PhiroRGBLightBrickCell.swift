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

class PhiroRGBLightBrickCell: BrickCell {
    weak var variableComboBoxView: iOSCombobox?

    weak var valueTextField1: UITextField?
    weak var valueTextField2: UITextField?
    weak var valueTextField3: UITextField?
    private var firstRowTextLabel: UILabel?
    private var thirdRowTextLabel1: UILabel?
    private var thirdRowTextLabel2: UILabel?
    private var thirdRowTextLabel3: UILabel?
    
    override func draw(_ rect: CGRect) {
        BrickShapeFactory.drawSquareBrickShape(withFill: UIColor.phiroBrick(),
                                               stroke: UIColor.phiroBrickStroke(),
                                               height: CGFloat(largeBrick),
                                               width: Util.screenWidth())
    }
    
    override func cellHeight() -> CGFloat {
        return BrickHeightType.height3.rawValue
    }
    
    override func hookUpSubViews(_ inlineViewSubViews: [Any]?) {
        firstRowTextLabel = inlineViewSubViews?[0] as? UILabel
        variableComboBoxView = inlineViewSubViews?[1] as? iOSCombobox
        thirdRowTextLabel1 = inlineViewSubViews?[2] as? UILabel
        valueTextField1 = inlineViewSubViews?[3] as? UITextField
        thirdRowTextLabel2 = inlineViewSubViews?[4] as? UILabel
        valueTextField2 = inlineViewSubViews?[5] as? UITextField
        thirdRowTextLabel3 = inlineViewSubViews?[6] as? UILabel
        valueTextField3 = inlineViewSubViews?[7] as? UITextField
    }
}
