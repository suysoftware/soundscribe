//
//  FileDownloader.swift
//  Runner
//
//  Created by ILION INC on 18.03.2023.
//

import Foundation

class FileDownloader : NSObject, URLSessionDownloadDelegate {

    var url : URL?
    // will be used to do whatever is needed once download is complete
    var yourOwnObject : NSObject?

    init(_ yourOwnObject : NSObject)
    {
        self.yourOwnObject = yourOwnObject
    }

    //is called once the download is complete
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL)
    {
        //copy downloaded data to your documents directory with same names as source file
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        //FileManager.default.

        let destinationUrl = documentsUrl!.appendingPathComponent(url!.lastPathComponent)
        let dataFromURL = NSData(contentsOf: location)
        dataFromURL?.write(to: destinationUrl, atomically: true)

        //now it is time to do what is needed to be done after the download
        //yourOwnObject!.callWhatIsNeeded()
    }

    //this is to track progress
    private func URLSession(session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64)
    {
    }

    // if there is an error during download this will be called
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?)
    {
        if(error != nil)
        {
            //handle the error
            print("Download completed with error: \(error!.localizedDescription)");
        }
    }

    //method to be called to download
    func download(url: URL)
    {
        self.url = url

        //download identifier can be customized. I used the "ulr.absoluteString"
        let sessionConfig = URLSessionConfiguration.background(withIdentifier: url.absoluteString)
        let session = Foundation.URLSession(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url)
        task.resume()
    }

}
