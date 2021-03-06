//
//  NetworkingToolbox.swift
//  WHSchemer
//
//  Created by Dingtr on 10/12/16.
//  Copyright © 2016 Dingtr. All rights reserved.
//

import Foundation
import Alamofire

let kStatusChangedNotification = "StatusChangedNotification"

enum INZStatus: String {
    case Outsider = "Logged out"
    case Insider0 = "Logged in but no application"
    case Insider1 = "Logged in & at stage1"
    case Insider2 = "Logged in & at stage2"
    case Insider3 = "Logged in & at stage3"
    case Insider4 = "Logged in & at stage4"
    case NotSure = "WTH"
}

class WHVNetworking {
    static var status: INZStatus = .Outsider
    static func setup() {
        Alamofire.SessionManager.default.delegate.taskWillPerformHTTPRedirection = {session, task, response, request in
            if status == .Outsider {
                //Logged in successfully
                let headers = response.allHeaderFields
                if let location = headers["Location"] as? String {
                    if location == "http://onlineservices.immigration.govt.nz/migrant/default.htm" {
                        status = .Insider0
                        //Dispense notification in main thread
                        DispatchQueue.main.async(execute: {
                            statusChanged()
                        })
                    }
                }
            } else if status == .Insider0 {
                
            } else if status == .Insider1 {
                
            } else if status == .Insider2 {
                
            } else if status == .Insider3 {
                
            } else if status == .Insider4 {
                
            }
            print(response)
            return request
        }
    }
    
    static func statusChanged() {
        //Send out the notifications
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kStatusChangedNotification), object: self, userInfo: nil)
    }
    
    static func loginAs(username: String, password: String) {
        
        let url = "https://onlineservices.immigration.govt.nz/Templates/Secure/Login.aspx?NRMODE=Published&NRNODEGUID=%7b4DE5075C-B9EE-4A38-BA45-C24832C3DBEC%7d&NRORIGINALURL=%2fsecure%2fLogin%2bWorking%2bHoliday%2ehtm%3f_ga%3d1%2e127874637%2e1598889550%2e1469944066&NRCACHEHINT=Guest&_ga=1.127874637.1598889550.1469944066"
        
        //FIXME: - I really dont know WTF '__VIEWSTATE' is. Thank you for your understanding....
        //fuckfuckfuckfuckfuck
        let params = [
                    "__VIEWSTATE": "dDwxMDA1ODA0MzMwO3Q8O2w8aTwwPjtpPDE+Oz47bDx0PDtsPGk8Mz47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47dDw7bDxpPDA+O2k8Mj47aTw0PjtpPDg+O2k8MTI+O2k8MTQ+O2k8MTY+O2k8MjA+Oz47bDx0PDtsPGk8MD47aTwyPjtpPDM+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+O2w8aTwxPjs+O2w8dDw7bDxpPDE+O2k8Mz47aTw1PjtpPDc+O2k8OT47aTwxMT47PjtsPHQ8cDxsPFRleHQ7PjtsPCAtIDs+Pjs7Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8O2w8aTwxPjs+O2w8dDxwPGw8dGl0bGU7b25jbGljaztpbm5lcmh0bWw7PjtsPExpbmsgb3BlbnMgaW4gYSBuZXcgd2luZG93O3dpbmRvdy5vcGVuKCcvcmVnaXN0cmF0aW9uL21hbmFnZXN1aXRjYXNlLmFzcHgnLCdtYW5hZ2VzdWl0Y2FzZXBvcHVwJywndG9vbGJhcj1ubyxsb2NhdGlvbj1ubyxzdGF0dXM9eWVzLG1lbnViYXI9bm8sc2Nyb2xsYmFycz15ZXMscmVzaXphYmxlPXllcyx3aWR0aD04NDAsaGVpZ2h0PTUyMCcpXDsgcmV0dXJuIGZhbHNlO01hbmFnZSBGYXZvdXJpdGVzOz4+Ozs+Oz4+O3Q8O2w8aTwxPjs+O2w8dDxwPGw8dGl0bGU7b25jbGljaztpbm5lcmh0bWw7PjtsPExpbmsgb3BlbnMgaW4gYSBuZXcgd2luZG93O3dpbmRvdy5vcGVuKCcvcmVnaXN0cmF0aW9uL3doYXRzaGFwcGVuaW5nLmFzcHgnLCd3aGF0c2hhcHBlbmluZ3BvcHVwJywndG9vbGJhcj1ubyxsb2NhdGlvbj1ubyxzdGF0dXM9eWVzLG1lbnViYXI9bm8sc2Nyb2xsYmFycz15ZXMscmVzaXphYmxlPXllcyx3aWR0aD04NDAsaGVpZ2h0PTUyMCcpXDsgcmV0dXJuIGZhbHNlO015IEFwcGxpY2F0aW9uOz4+Ozs+Oz4+O3Q8cDxsPGhyZWY7PjtsPC9SZWdpc3RyYXRpb24vTG9nT3V0LmFzcHg7Pj47Oz47dDxwPGw8VGV4dDs+O2w8XDxhIGhyZWY9Imh0dHA6Ly93d3cuaW1taWdyYXRpb24uZ292dC5uei9taWdyYW50L2dlbmVyYWwvYWJvdXRuemlzL2NvbnRhY3R1cy9kZWZhdWx0Lmh0bSJcPkNvbnRhY3QgVXNcPC9hXD47Pj47Oz47Pj47Pj47dDw7bDxpPDA+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+Oz4+O3Q8O2w8aTwwPjs+O2w8dDxwPGw8VGV4dDs+O2w8XDxhIGhyZWY9Ii8iXD5Ib21lXDwvYVw+ICZndFw7IFw8YSBocmVmPSIvc2VjdXJlLyJcPkxvZ2luXDwvYVw+Oz4+Ozs+Oz4+Oz4+O3Q8O2w8aTwwPjs+O2w8dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjs+Pjt0PDtsPGk8MD47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47dDx0PHA8bDxEYXRhVGV4dEZpZWxkO0RhdGFWYWx1ZUZpZWxkOz47bDxLZXk7VmFsdWU7Pj47dDxpPDQ+O0A8Q2hlY2sgdGhlIHN0YXR1cyBvZiB5b3VyIGFwcGxpY2F0aW9uO1NraWxsZWQgTWlncmFudCAtIGV4cHJlc3Npb24gb2YgaW50ZXJlc3Q7U2lsdmVyIEZlcm4gSm9iIFNlYXJjaCB2aXNhO1dvcmtpbmcgSG9saWRheSB2aXNhOz47QDwvc2VjdXJlL3N0YXR1cy5odG07L3NlY3VyZS9Mb2dpbitTa2lsbGVkK01pZ3JhbnQuaHRtOy9zZWN1cmUvTG9naW4rU2lsdmVyK0Zlcm4uaHRtOy9zZWN1cmUvTG9naW4rV29ya2luZytIb2xpZGF5Lmh0bTs+Pjs+Ozs+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDE+Oz47bDx0PDtsPGk8MD47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDE+Oz47bDx0PHA8cDxsPFRleHQ7PjtsPFNlbGVjdCB3aGljaCB0eXBlIG9mIGxvZ2luIHRvIGRpc3BsYXksIGlmIGFueTs+Pjs+Ozs+Oz4+Oz4+Oz4+O3Q8O2w8aTwxPjs+O2w8dDw7bDxpPDA+Oz47bDx0PDtsPGk8MT47aTwzPjtpPDU+O2k8OT47aTwxMT47aTwxMz47PjtsPHQ8cDxsPG9uY2xpY2s7aW5uZXJodG1sO3RpdGxlOz47bDx3aW5kb3cub3BlbignL3JlZ2lzdHJhdGlvbi9DcmVhdGVBY2NvdW50LmFzcHgnLCdyZWdpc3RlcicsJ3Rvb2xiYXI9bm8sbG9jYXRpb249bm8sc3RhdHVzPXllcyxtZW51YmFyPW5vLHNjcm9sbGJhcnM9eWVzLHJlc2l6YWJsZT15ZXMsd2lkdGg9NzIwLGhlaWdodD01MjAnKVw7IHJldHVybiBmYWxzZTtjcmVhdGUgDQoJCQkJCWFuIGFjY291bnQ7TGluayBvcGVucyBpbiBhIG5ldyB3aW5kb3c7Pj47Oz47dDxwPGw8b25rZXlwcmVzczs+O2w8ZmlyZURlZmF1bHRCdXR0b24oJ09ubGluZVNlcnZpY2VzTG9naW5TdGVhbHRoX1Zpc2FMb2dpbkNvbnRyb2xfbG9naW5JbWFnZUJ1dHRvbicpOz4+Ozs+O3Q8cDxsPG9ua2V5cHJlc3M7PjtsPGZpcmVEZWZhdWx0QnV0dG9uKCdPbmxpbmVTZXJ2aWNlc0xvZ2luU3RlYWx0aF9WaXNhTG9naW5Db250cm9sX2xvZ2luSW1hZ2VCdXR0b24nKTs+Pjs7Pjt0PDtsPGk8MT47PjtsPHQ8cDxsPFRleHQ7VmlzaWJsZTs+O2w8O288Zj47Pj47Oz47Pj47dDxwPGw8b25jbGljaztpbm5lcmh0bWw7dGl0bGU7PjtsPHdpbmRvdy5vcGVuKCcvUmVnaXN0cmF0aW9uL0ZvcmdvdFBhc3N3b3JkU3RlcDEuYXNweCcsJ1JlZ2lzdHJhdGlvbicsJ3Rvb2xiYXI9bm8sbG9jYXRpb249bm8sc3RhdHVzPXllcyxtZW51YmFyPW5vLHNjcm9sbGJhcnM9eWVzLHJlc2l6YWJsZT15ZXMsd2lkdGg9NjAwLGhlaWdodD00MzQnKVw7IHJldHVybiBmYWxzZTtGb3Jnb3R0ZW4gcGFzc3dvcmQ/O0xpbmsgb3BlbnMgaW4gYSBuZXcgd2luZG93Oz4+Ozs+O3Q8cDxsPG9uY2xpY2s7aW5uZXJodG1sO3RpdGxlOz47bDx3aW5kb3cub3BlbignaHR0cDovL2Zvcm1zaGVscC5pbW1pZ3JhdGlvbi5nb3Z0Lm56L1NraWxsZWRNaWdyYW50L0V4cHJlc3Npb25PZkludGVyZXN0L0NBTG9naW4uaHRtJywnbmV3cG9wdXAnLCd0b29sYmFyPW5vLGxvY2F0aW9uPW5vLHN0YXR1cz15ZXMsbWVudWJhcj1ubyxzY3JvbGxiYXJzPXllcyxyZXNpemFibGU9eWVzLHdpZHRoPTYwMCxoZWlnaHQ9NDM0JylcOyByZXR1cm4gZmFsc2U7Q2FuJ3QgbG9naW4/O0xpbmsgb3BlbnMgaW4gYSBuZXcgd2luZG93Oz4+Ozs+Oz4+Oz4+Oz4+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDw7bDxpPDA+O2k8Mj47PjtsPHQ8cDxwPGw8VmlzaWJsZTs+O2w8bzx0Pjs+Pjs+O2w8aTwwPjtpPDI+O2k8ND47aTw2PjtpPDg+O2k8MTA+O2k8MTI+O2k8MTQ+O2k8MTY+O2k8MTg+O2k8MjI+O2k8MjQ+O2k8MjY+O2k8Mjg+Oz47bDx0PDtsPGk8MD47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88dD47Pj47bDxpPDE+Oz47bDx0PHA8bDxUZXh0Oz47bDwwOSBEZWMgMjAxNjs+Pjs7Pjs+Pjs+Pjt0PDtsPGk8MT47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47dDw7bDxpPDA+O2k8Mj47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjs+Pjt0PDtsPGk8MD47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47dDw7bDxpPDA+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+O2w8aTwxPjs+O2w8dDw7bDxpPDA+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+Oz4+Oz4+Oz4+O3Q8cDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs+O2w8aTwxPjs+O2w8dDw7bDxpPDk+Oz47bDx0PHA8cDxsPEVuYWJsZWQ7VmlzaWJsZTs+O2w8bzxmPjtvPGY+Oz4+Oz47Oz47Pj47Pj47dDxwPHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Oz47bDxpPDA+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+O2w8aTw3Pjs+O2w8dDxAMDw7Ozs7Ozs7Ozs7Pjs7Pjs+Pjs+Pjt0PHA8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47PjtsPGk8MT47aTwzPjtpPDU+Oz47bDx0PDtsPGk8MT47aTwzPjs+O2w8dDxwPGw8VGV4dDs+O2w8XDxsYWJlbCBmb3I9IkZvb3Rlcl9uZXdGb290ZXJfVmlld0luZm9Gb3JMaW5rc19WaWV3SW5mb0ZvckxpbmtzTGlzdCJcPjs+Pjs7Pjt0PHA8bDxUZXh0Oz47bDxcPC9sYWJlbFw+Oz4+Ozs+Oz4+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47dDx0PHA8cDxsPERhdGFUZXh0RmllbGQ7RGF0YVZhbHVlRmllbGQ7PjtsPGtleTt2YWx1ZTs+Pjs+O3Q8aTwyPjtAPFxlO1xlOz47QDxcZTtcZTs+Pjs+Ozs+Oz4+O3Q8cDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs+O2w8aTwxPjtpPDM+O2k8NT47PjtsPHQ8O2w8aTwxPjs+O2w8dDxwPGw8VGV4dDs+O2w8XDxsYWJlbCBmb3I9IkZvb3Rlcl9uZXdGb290ZXJfSVdhbnRUb0xpbmtzX0lXYW50VG9MaW5rc0xpc3QiXD47Pj47Oz47Pj47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+PjtsPGk8MD47PjtsPHQ8cDxsPFRleHQ7PjtsPFw8bGFiZWwgZm9yPSJGb290ZXJfbmV3Rm9vdGVyX0lXYW50VG9MaW5rc19JV2FudFRvTGlua3NMaXN0Ilw+Oz4+Ozs+Oz4+O3Q8dDxwPHA8bDxEYXRhVGV4dEZpZWxkO0RhdGFWYWx1ZUZpZWxkOz47bDxrZXk7dmFsdWU7Pj47Pjt0PGk8Mj47QDxcZTtcZTs+O0A8XGU7XGU7Pj47Pjs7Pjs+Pjt0PDtsPGk8Mj47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDM+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+Oz4+Oz4+O3Q8O2w8aTwwPjs+O2w8dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjs+Pjt0PDtsPGk8MD47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjt0PDtsPGk8MD47aTwyPjtpPDQ+O2k8Nj47PjtsPHQ8O2w8aTwxPjtpPDM+O2k8NT47PjtsPHQ8cDxsPFRleHQ7PjtsPFw8QSBocmVmPSJodHRwOi8vd3d3Lm5ld3plYWxhbmQuZ292dC5uei8iXD5cPElNRyBib3JkZXI9IjAiIGFsdD0iR28gdG8gd3d3Lm5ld3plYWxhbmQuZ292dC5uei4gIiBzcmM9Ii9OUi9yZG9ubHlyZXMvRjdBMjE2NDQtNDVCMy00QzM1LUE1MUYtMjlFN0RENjg3RTk3LzAvbnpnb3Z0bG9nby5wbmciXD5cPC9BXD4mbmJzcFw7Jm5ic3BcOzs+Pjs7Pjt0PHA8bDxUZXh0Oz47bDxcZTs+Pjs7Pjt0PHA8bDxUZXh0Oz47bDxcZTs+Pjs7Pjs+Pjt0PDtsPGk8MD47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDA+O2k8MT47aTwyPjs+O2w8dDw7bDxpPDA+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+Oz4+O3Q8O2w8aTwwPjs+O2w8dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs7Pjs+Pjt0PDtsPGk8MD47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Oz47Pj47Pj47Pj47dDw7bDxpPDA+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+Oz4+O3Q8O2w8aTwwPjs+O2w8dDxwPHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Oz47Oz47Pj47Pj47Pj47dDw7bDxpPDE+O2k8Mz47aTw3PjtpPDk+O2k8MTE+O2k8MTM+O2k8MTU+O2k8MTc+O2k8MTk+O2k8MjE+O2k8MjM+O2k8Mjk+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8O2w8aTwwPjs+O2w8dDxwPGw8VmlzaWJsZTs+O2w8bzx0Pjs+PjtsPGk8MT47PjtsPHQ8cDxsPFRleHQ7PjtsPDA5IERlYyAyMDE2Oz4+Ozs+Oz4+Oz4+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDE+Oz47bDx0PDtsPGk8MT47aTwzPjtpPDU+Oz47bDx0PDtsPGk8MT47PjtsPHQ8cDxsPFRleHQ7PjtsPFw8bGFiZWwgZm9yPSJGb290ZXJfTWlncmFudFNpdGVTdGVhbHRoX0lXYW50VG9MaW5rc19JV2FudFRvTGlua3NMaXN0Ilw+Oz4+Ozs+Oz4+O3Q8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDA+Oz47bDx0PHA8bDxUZXh0Oz47bDxcPGxhYmVsIGZvcj0iRm9vdGVyX01pZ3JhbnRTaXRlU3RlYWx0aF9JV2FudFRvTGlua3NfSVdhbnRUb0xpbmtzTGlzdCJcPjs+Pjs7Pjs+Pjt0PHQ8cDxwPGw8RGF0YVRleHRGaWVsZDtEYXRhVmFsdWVGaWVsZDs+O2w8a2V5O3ZhbHVlOz4+Oz47dDxpPDI+O0A8XGU7XGU7PjtAPFxlO1xlOz4+Oz47Oz47Pj47Pj47dDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+PjtsPGk8MT47PjtsPHQ8O2w8aTwxPjtpPDM+O2k8NT47PjtsPHQ8O2w8aTwxPjtpPDM+Oz47bDx0PHA8bDxUZXh0Oz47bDxcPGxhYmVsIGZvcj0iRm9vdGVyX0NvbW11bml0eVNpdGVTdGVhbHRoX1ZpZXdJbmZvRm9yTGlua3NfVmlld0luZm9Gb3JMaW5rc0xpc3QiXD47Pj47Oz47dDxwPGw8VGV4dDs+O2w8XDwvbGFiZWxcPjs+Pjs7Pjs+Pjt0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+O3Q8dDxwPHA8bDxEYXRhVGV4dEZpZWxkO0RhdGFWYWx1ZUZpZWxkOz47bDxrZXk7dmFsdWU7Pj47Pjt0PGk8Mj47QDxcZTtcZTs+O0A8XGU7XGU7Pj47Pjs7Pjs+Pjs+Pjt0PDtsPGk8MT47PjtsPHQ8cDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs+O2w8aTw1PjtpPDc+O2k8OT47PjtsPHQ8O2w8aTwxPjs+O2w8dDw7bDxpPDE+Oz47bDx0PDtsPGk8MD47PjtsPHQ8O2w8aTwxPjs+O2w8dDxAMDw7Ozs7Ozs7Ozs7Pjs7Pjs+Pjs+Pjs+Pjs+Pjt0PDtsPGk8MT47PjtsPHQ8O2w8aTwxPjs+O2w8dDw7bDxpPDA+Oz47bDx0PDtsPGk8MT47PjtsPHQ8QDA8Ozs7Ozs7Ozs7Oz47Oz47Pj47Pj47Pj47Pj47dDw7bDxpPDE+Oz47bDx0PDtsPGk8MT47PjtsPHQ8O2w8aTwwPjs+O2w8dDw7bDxpPDE+Oz47bDx0PEAwPDs7Ozs7Ozs7Ozs+Ozs+Oz4+Oz4+Oz4+Oz4+Oz4+Oz4+O3Q8cDxwPGw8VmlzaWJsZTs+O2w8bzxmPjs+Pjs+O2w8aTwxPjs+O2w8dDw7bDxpPDE+O2k8Mz47PjtsPHQ8cDxsPGhyZWY7dGl0bGU7b25jbGljazs+O2w8aHR0cDovL2Zvcm1zaGVscC5pbW1pZ3JhdGlvbi5nb3Z0Lm56L29ubGluZXNlcnZpY2VzL2hlbHAvb25saW5lc2VydmljZXMuaHRtO09wZW5zIGEgbmV3IHdpbmRvdzt3aW5kb3cub3BlbignaHR0cDovL2Zvcm1zaGVscC5pbW1pZ3JhdGlvbi5nb3Z0Lm56L29ubGluZXNlcnZpY2VzL2hlbHAvb25saW5lc2VydmljZXMuaHRtJywnJywndG9vbGJhcj1ubyxsb2NhdGlvbj1ubyxzdGF0dXM9bm8sbWVudWJhcj1ubyxzY3JvbGxiYXJzPXllcyxyZXNpemFibGU9eWVzLHdpZHRoPTc1MCxoZWlnaHQ9NDUwJylcOyByZXR1cm4gZmFsc2U7Pj47Oz47dDxwPHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Oz47bDxpPDE+O2k8Mz47aTw1Pjs+O2w8dDxwPGw8dGl0bGU7aHJlZjtvbmNsaWNrO2lubmVyaHRtbDs+O2w8TGluayBvcGVucyBpbiBhIG5ldyB3aW5kb3c7L2Nzc20vVXNlcnMvSG9tZS5hc3B4O3dpbmRvdy5vcGVuKCcvY3NzbS9Vc2Vycy9Ib21lLmFzcHgnLCdDU1NNJywndG9vbGJhcj1ubyxsb2NhdGlvbj1ubyxzdGF0dXM9eWVzLG1lbnViYXI9bm8sc2Nyb2xsYmFycz15ZXMscmVzaXphYmxlPXllcyx3aWR0aD04NDAsaGVpZ2h0PTUyMCcpXDsgcmV0dXJuIGZhbHNlO0V4cHJlc3Npb24gb2YgSW50ZXJlc3Q7Pj47Oz47dDxwPGw8aHJlZjt0aXRsZTtvbmNsaWNrO2lubmVyaHRtbDs+O2w8L1NpbHZlckZlcm4vSG9tZS9JbmRleDtMaW5rIG9wZW5zIGluIGEgbmV3IHdpbmRvdzt3aW5kb3cub3BlbignL1NpbHZlckZlcm4vSG9tZS9JbmRleCcsJ1NpbHZlckZlcm4nLCd0b29sYmFyPW5vLGxvY2F0aW9uPW5vLHN0YXR1cz15ZXMsbWVudWJhcj1ubyxzY3JvbGxiYXJzPXllcyxyZXNpemFibGU9eWVzLHdpZHRoPTg0MCxoZWlnaHQ9NTIwJylcOyByZXR1cm4gZmFsc2U7U2lsdmVyIEZlcm4gSm9iIFNlYXJjaDs+Pjs7Pjt0PHA8bDx0aXRsZTtocmVmO29uY2xpY2s7aW5uZXJodG1sOz47bDxMaW5rIG9wZW5zIGluIGEgbmV3IHdpbmRvdzsvV29ya2luZ0hvbGlkYXkvO3dpbmRvdy5vcGVuKCcvV29ya2luZ0hvbGlkYXkvJywnV0hTJywndG9vbGJhcj1ubyxsb2NhdGlvbj1ubyxzdGF0dXM9eWVzLG1lbnViYXI9bm8sc2Nyb2xsYmFycz15ZXMscmVzaXphYmxlPXllcyx3aWR0aD04NDAsaGVpZ2h0PTUyMCcpXDsgcmV0dXJuIGZhbHNlO1dvcmtpbmcgSG9saWRheTs+Pjs7Pjs+Pjs+Pjs+Pjt0PHA8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47PjtsPGk8MT47PjtsPHQ8O2w8aTwxPjs+O2w8dDxwPGw8dGl0bGU7b25jbGljaztpbm5lcmh0bWw7PjtsPExpbmsgb3BlbnMgaW4gYSBuZXcgd2luZG93O3dpbmRvdy5vcGVuKCdodHRwOi8vZm9ybXNoZWxwLmltbWlncmF0aW9uLmdvdnQubnovb25saW5lc2VydmljZXMvaGVscC9tZXNzYWdlcy5odG0nLCduZXdwb3B1cCcsJ3Rvb2xiYXI9bm8sbG9jYXRpb249bm8sc3RhdHVzPXllcyxtZW51YmFyPW5vLHNjcm9sbGJhcnM9eWVzLHJlc2l6YWJsZT15ZXMsd2lkdGg9NjAwLGhlaWdodD00MzQnKVw7IHJldHVybiBmYWxzZTtcZTs+Pjs7Pjs+Pjs+Pjt0PDtsPGk8Mj47PjtsPHQ8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47bDxpPDM+Oz47bDx0PHA8bDxWaXNpYmxlOz47bDxvPGY+Oz4+Ozs+Oz4+Oz4+O3Q8O2w8aTwwPjs+O2w8dDxwPGw8VmlzaWJsZTs+O2w8bzx0Pjs+Pjs7Pjs+Pjt0PHA8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47PjtsPGk8MT47PjtsPHQ8O2w8aTwxPjs+O2w8dDxwPHA8bDxUZXh0Oz47bDwwMSBKYW4gMDAwMSwgMDA6MDA7Pj47Pjs7Pjs+Pjs+Pjt0PDtsPGk8MT47aTwzPjtpPDU+Oz47bDx0PHA8bDxUZXh0Oz47bDxcPEEgaHJlZj0iaHR0cDovL3d3dy5uZXd6ZWFsYW5kLmdvdnQubnovIlw+XDxJTUcgYm9yZGVyPSIwIiBhbHQ9IkdvIHRvIHd3dy5uZXd6ZWFsYW5kLmdvdnQubnouICIgc3JjPSIvTlIvcmRvbmx5cmVzL0Y3QTIxNjQ0LTQ1QjMtNEMzNS1BNTFGLTI5RTdERDY4N0U5Ny8wL256Z292dGxvZ28ucG5nIlw+XDwvQVw+Jm5ic3BcOyZuYnNwXDs7Pj47Oz47dDxwPGw8VGV4dDs+O2w8XGU7Pj47Oz47dDxwPGw8VGV4dDs+O2w8XGU7Pj47Oz47Pj47dDw7bDxpPDA+Oz47bDx0PHA8cDxsPFZpc2libGU7PjtsPG88Zj47Pj47Pjs7Pjs+Pjs+Pjs+Pjs+Pjs+PjtsPEhlYWRlckNvbW11bml0eUhvbWVwYWdlOlNlYXJjaENvbnRyb2w6YnRuR287T25saW5lU2VydmljZXNMb2dpblN0ZWFsdGg6VmlzYUxvZ2luQ29udHJvbDpsb2dpbkltYWdlQnV0dG9uOz4+0ZV4OXzyIN1cTfty6aElMYxF6+4=",
                    "__VIEWSTATEGENERATOR": "D25317F4",
                    "HeaderCommunityHomepage:SearchControl:txtSearchString": "",
                      "VisaDropDown": "/secure/Login+Working+Holiday.htm",
                      "OnlineServicesLoginStealth:VisaLoginControl:userNameTextBox": username,
                      "OnlineServicesLoginStealth:VisaLoginControl:passwordTextBox": password,
                      "OnlineServicesLoginStealth:VisaLoginControl:loginImageButton.x":	"42",
                      "OnlineServicesLoginStealth:VisaLoginControl:loginImageButton.y":	"12"]
        
        let headers: HTTPHeaders = [
            "Accept-Language": "en-us",
            "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
            "Content-Type": "application/x-www-form-urlencoded",
            "Origin": "https://onlineservices.immigration.govt.nz",
            "Referer": "https://onlineservices.immigration.govt.nz/secure/Login+Working+Holiday.htm?_ga=1.127874637.1598889550.1469944066"
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: headers).responseString { response in
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
        }
    }
    
}
