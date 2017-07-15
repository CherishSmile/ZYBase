//
//  ZYCustomSystemAlert.swift
//  ZYBase
//
//  Created by Mzywx on 2017/3/1.
//  Copyright © 2017年 Mzywx. All rights reserved.
//

import UIKit


private let AlertViewWidth:CGFloat = 270.0
private let AlertViewContentMargin:CGFloat = 9.0
private let AlertViewVerticalElementSpace:CGFloat = 10.0
private let AlertViewButtonHeight:CGFloat = 44.0
private let AlertViewLineLayerWidth:CGFloat = 0.5

public typealias ZYActionAlertCompletionClosure = (_ isCancle:Bool,Int) -> Void

open class ZYCustomActionAlert: BaseAlertView {

    
    var titleLabel : UILabel!
    var messageLabel : UILabel!
    var cancelButton : UIButton!
    var otherButton : UIButton!
    var buttons : Array<UIButton>?
    var buttonsY : CGFloat?
    var verticalLine : CALayer?
    var completion : ZYActionAlertCompletionClosure?
    
    
    
    public convenience init(title:String?,message:String?,cancleTitle:String?,otherTitle:String?,completion:@escaping ZYActionAlertCompletionClosure) {
        self.init(frame:.zero,title:title,message:message,cancleTitle:cancleTitle,otherTitle:otherTitle,completion:completion)
    }
    
    
    init(frame:CGRect,title:String?,message:String?,cancleTitle:String?,otherTitle:String?,completion:@escaping ZYActionAlertCompletionClosure) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4.0
        titleLabel = UILabel(frame: CGRect(x: AlertViewContentMargin, y: message != nil && (message?.characters.count)!>0 ? AlertViewVerticalElementSpace:2*AlertViewVerticalElementSpace, width: AlertViewWidth - AlertViewContentMargin*2, height: 44))
        titleLabel.text = title
        titleLabel.backgroundColor = .clear
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.frame = adjustLabelFrameHeight(label: titleLabel)
        titleLabel.numberOfLines = 0
        
        
        if title != nil && (title?.characters.count)! > 0 {
            self.addSubview(titleLabel)
        }
        
        let messageLabelY = titleLabel.frame.origin.y + titleLabel.frame.size.height + AlertViewVerticalElementSpace
        
        messageLabel = UILabel(frame: CGRect(x: AlertViewContentMargin, y: messageLabelY, width: AlertViewWidth - AlertViewContentMargin*2, height: 44))
        messageLabel.text = message
        messageLabel.backgroundColor = .clear
        messageLabel.textColor = .black
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.systemFont(ofSize: 15)
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.frame = adjustLabelFrameHeight(label: messageLabel)
        messageLabel.numberOfLines = 0
        if message != nil && (message?.characters.count)!>0 {
            self.addSubview(messageLabel)
        }
        
        //line
        let lineLayer = setLineLayer()
        //title不存在，message存在
        if (title == nil||title?.characters.count == 0) && (message != nil && (message?.characters.count)! > 0) {
            lineLayer.frame = CGRect(x: 0, y: messageLabel.frame.origin.y+AlertViewVerticalElementSpace + messageLabel.frame.size.height + AlertViewVerticalElementSpace, width: AlertViewWidth, height: AlertViewLineLayerWidth)
        }
        //title存在，message不存在
        if (title != nil && (title?.characters.count)!>0) && (message == nil||message?.characters.count==0) {
            lineLayer.frame = CGRect(x: 0, y: titleLabel.frame.origin.y+AlertViewVerticalElementSpace + titleLabel.frame.size.height + AlertViewVerticalElementSpace, width: AlertViewWidth, height: AlertViewLineLayerWidth)
        }
        //title,message都不存在
        if (title == nil||title?.characters.count==0) && (message == nil||message?.characters.count==0) {
            lineLayer.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        //title,message都存在
        if (title != nil&&(title?.characters.count)!>0) && (message != nil&&(message?.characters.count)!>0) {
            lineLayer.frame = CGRect(x: 0, y: messageLabel.frame.origin.y + messageLabel.frame.size.height + AlertViewVerticalElementSpace, width: AlertViewWidth, height: AlertViewLineLayerWidth)
        }
        self.layer.addSublayer(lineLayer)
        
        buttonsY = lineLayer.frame.origin.y + lineLayer.frame.size.height
        
        if cancleTitle != nil && (cancleTitle?.characters.count)!>0 {
            addButtonWithTitle(title: cancleTitle!)
        }
        if otherTitle != nil && (otherTitle?.characters.count)!>0 {
            addButtonWithTitle(title: otherTitle!)
        }
        
        self.bounds = CGRect(x: 0, y: 0, width: AlertViewWidth, height: 150)
        
        self.completion = completion
        
        self.resizeViewsWithTitle(title: title, message: message)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     *  alert的frame
     */
    func resizeViewsWithTitle(title:String?,message:String?)  {
        var totalHeight : CGFloat = 0
        for view in self.subviews {
            if !(view is UIButton) {
                totalHeight = totalHeight + view.frame.size.height + AlertViewVerticalElementSpace
            }
        }
        if let btns = buttons {
            if btns.count>0 {
                let otherButtonsCount:Int = btns.count
                if otherButtonsCount>2 {
                    totalHeight = totalHeight + AlertViewButtonHeight * CGFloat(otherButtonsCount)
                }else{
                    totalHeight = totalHeight + AlertViewButtonHeight
                }
            }
        }
        //title存在，message不存在或者message存在，title不存在
        if ((title == nil || (title?.characters.count)!==0) && (message != nil && (message?.characters.count)!>0))||((title != nil && (title?.characters.count)!>0) && (message == nil||(message?.characters.count)!==0))  {
            totalHeight = totalHeight + 3*AlertViewVerticalElementSpace
        }
        //title和message都存在
        if (title != nil&&(title?.characters.count)!>0) && (message != nil && (message?.characters.count)!>0) {
            totalHeight = totalHeight+AlertViewVerticalElementSpace
        }
        self.frame = CGRect(x: (SCREEN_WIDTH-self.frame.size.width)/2, y: (SCREEN_HEIGHT-totalHeight)/2, width: self.frame.size.width, height: totalHeight)
        
    }
    /**
     *  设置间隔线
     */
    func setLineLayer() -> CALayer {
        let layer = CALayer()
        layer.backgroundColor = UIColor(white: 0.9, alpha: 1).cgColor
        return layer
    }
    
    /**
     *  添加按钮
     */
    func addButtonWithTitle(title:String?){
        let button = genericButton()
        button.setTitle(title, for: .normal)
        if cancelButton == nil {
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
            cancelButton = button
            cancelButton.frame = CGRect(x: 0, y: buttonsY!, width: AlertViewWidth, height: AlertViewButtonHeight)
        }else if buttons != nil && (buttons?.count)!>1{
            let lastButton = (buttons?.last)! as UIButton
            lastButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
            if buttons?.count == 2 {
                verticalLine?.removeFromSuperlayer()
                let lineLayer = setLineLayer()
                lineLayer.frame = CGRect(x: 0, y: buttonsY! + AlertViewButtonHeight, width: AlertViewWidth, height: AlertViewLineLayerWidth)
                self.layer.addSublayer(lineLayer)
                lastButton.frame = CGRect(x: 0, y: buttonsY! + AlertViewButtonHeight, width: AlertViewWidth, height: AlertViewButtonHeight)
                cancelButton.frame = CGRect(x: 0, y: self.buttonsY!, width: AlertViewWidth, height: AlertViewButtonHeight)
            }
            let lastButtonYOffset = lastButton.frame.origin.y + AlertViewButtonHeight
            button.frame = CGRect(x: 0,y: lastButtonYOffset,width: AlertViewWidth,height: AlertViewButtonHeight)
            
        }else{
            verticalLine = setLineLayer()
            verticalLine?.frame = CGRect(x: AlertViewWidth/2,y: self.buttonsY!,width: AlertViewLineLayerWidth,height: AlertViewButtonHeight)
            self.layer.addSublayer(verticalLine!)
            button.frame = CGRect(x: AlertViewWidth/2,y: self.buttonsY!,width: AlertViewWidth/2,height: AlertViewButtonHeight)
            otherButton = button
            cancelButton.frame = CGRect(x: 0,y: buttonsY!,width: AlertViewWidth/2,height: AlertViewButtonHeight)
            cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        }
        self.addSubview(button)
        if buttons != nil {
            buttons?.append(button)
        }else{
            buttons = [button]
        }
    }
    /**
     *  标题、内容动态行高的计算
     *
     *  @return CGRect
     */
    func adjustLabelFrameHeight(label:UILabel) -> CGRect {
        var height:CGFloat = 0
        let context = NSStringDrawingContext()
        context.minimumScaleFactor = 1.0
        if let content = label.text {
            if content.characters.count>0 {
                let bounds = content.boundingRect(with: CGSize.init(width: label.frame.size.width, height: CGFloat(FLT_MAX)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName:label.font], context: context)
                
                height = bounds.size.height
                return CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.size.width, height: height )
            }else{
                return CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.size.width, height: 0)
            }
            
        }else{
            return CGRect(x: label.frame.origin.x, y: label.frame.origin.y, width: label.frame.size.width, height: 0)
        }
    }
    /**
     *  设置按钮属性
     */
    func genericButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2)
        button.setTitleColor(.lightGray, for: .normal)
        button.setTitleColor(UIColor.init(white: 0.25, alpha: 1), for: .highlighted)
        button.addTarget(self, action: #selector(dismiss(btn:)), for: .touchUpInside)
        button.addTarget(self, action: #selector(setBackgroundColorForButton(btn:)), for: .touchDown)
        button.addTarget(self, action: #selector(setBackgroundColorForButton(btn:)), for: .touchDragEnter)
        button.addTarget(self, action: #selector(clearBackgroundColorForButton(btn:)), for: .touchDragExit)
        return button
    }
    
    func setBackgroundColorForButton(btn:UIButton) {
        btn.backgroundColor = UIColor(red: 245/255.0, green: 245/255.0, blue: 245/255.0, alpha: 1.0)
    }
    func clearBackgroundColorForButton(btn:UIButton) {
        btn.backgroundColor = .clear
    }
    func dismiss(btn:UIButton)  {
        dismiss(btn: btn, animated: true)
    }
    /**
     *  Block回调
     */
    func dismiss(btn:UIButton,animated:Bool) {
        UIView.animate(withDuration: animated ? 0.2 : 0, animations: {
            self.alpha = 0
        }) { (finished) in
            if self.completion != nil {
                var cancled = false
                if btn == self.cancelButton {
                    cancled = true
                }
                var buttonIndex  = -1
                if (self.buttons?.count)!>0{
                    let index  = self.buttons?.index(of: btn)
                    if index != NSNotFound {
                        buttonIndex = index!
                    }
                    self.completion!(cancled,buttonIndex)
                }
            }
            self.dismissZYAlert()
        }
    }
    
    
    /*
     public var alertCornerRadius : CGFloat!
     public var titleColor : UIColor!
     public var messageColor : UIColor!
     public var cancleTitleColor : UIColor!
     public var otherTitleColor : UIColor!

     */
    
    //MARK: - 设置警告框的属性
    public func setAlertCornerRadius(_ radius:CGFloat) {
        self.layer.cornerRadius = radius
    }
    public func setTitleColor(_ color:UIColor) {
        titleLabel.textColor = color
    }
    public func setMessageColor(_ color:UIColor) {
        messageLabel.textColor = color
    }
    public func setCancleTitleColor(_ color:UIColor) {
        cancelButton.setTitleColor(color, for: .normal)
    }
    public func setOtherTitleColor(_ color:UIColor) {
        otherButton.setTitleColor(color, for: .normal)
    }
    public func setAlertTitleColor(_ color:UIColor,titleFont font:UIFont) {
        titleLabel.textColor=color
        titleLabel.font=font
    }
    public func setAlertMessageColor(_ color:UIColor,messageFont font:UIFont)  {
        messageLabel.textColor=color
        messageLabel.font=font
    }
    public func setAlertCancleTitleColor(_ color:UIColor,titleFont font:UIFont) {
        cancelButton.setTitleColor(color, for: .normal)
        cancelButton.titleLabel?.font = font
    }
    public func setAlertOtherTitleColor(_ color:UIColor,titleFont font:UIFont) {
        otherButton.setTitleColor(color, for: .normal)
        otherButton.titleLabel?.font = font
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
