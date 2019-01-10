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

class BrickCellStaticChoiceData: iOSCombobox, BrickCellDataProtocol, iOSComboboxDelegate {
    weak var brickCell: BrickCell?
    var lineNumber: Int = 0
    var parameterNumber: Int = 0
    static var messages: [AnyHashable]? = nil
    
    required init(frame: CGRect, andBrickCell brickCell: BrickCell?, andLineNumber line: Int, andParameterNumber parameter: Int) {
        //if super.init(frame: frame)
        
        self.brickCell = brickCell
        lineNumber = line
        parameterNumber = parameter
        
        var options: [String] = []
        var currentOptionIndex: Int = 0
        var optionIndex: Int = 0
        if brickCell?.scriptOrBrick is BrickStaticChoiceProtocol != nil {
            let choiceBrick = brickCell?.scriptOrBrick as? (Brick & BrickStaticChoiceProtocol)
            let currentChoice = choiceBrick?.choice(forLineNumber: line, andParameterNumber: parameter)
            for choice: String? in (choiceBrick?.possibleChoices(forLineNumber: line, andParameterNumber: parameter))! {
                options.append(choice ?? "")
                if (choice == currentChoice) {
                    currentOptionIndex = optionIndex
                }
                optionIndex += 1
            }
            if currentChoice != nil && !(options.contains(currentChoice ?? "")) {
                options.append(currentChoice ?? "")
                currentOptionIndex = optionIndex
            }
        } else {
            options.append(kLocalizedError)
        }
        values = options
        currentValue = options[currentOptionIndex]
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func comboboxDonePressed(_ combobox: iOSCombobox?, withValue value: String?) {
        brickCell?.dataDelegate?.updateBrickCellData(self, withValue: value)
    }
    
    func comboboxOpened(_ combobox: iOSCombobox?) {
        brickCell?.dataDelegate?.disableUserInteractionAndHighlight(brickCell, withMarginBottom: CGFloat(kiOSComboboxTotalHeight))
    }
    
    // MARK: - User interaction
    
    func isUserInteractionEnabled() -> Bool {
        return brickCell?.scriptOrBrick?.animateInsertBrick == false
    }
}
