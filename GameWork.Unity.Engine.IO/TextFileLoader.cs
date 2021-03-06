﻿using System.IO;
using GameWork.Core.IO.PlatformAdaptors;
using UnityEngine;

namespace GameWork.Unity.Engine.IO
{
	public class TextFileLoader : ITextFileLoader
	{
		public Stream Load(string path)
		{
			var textAsset = Resources.Load<TextAsset>(path);

			var stream = new MemoryStream();
			var writer = new StreamWriter(stream);
			writer.Write(textAsset.text);
			writer.Flush();
			stream.Position = 0;

			return stream;
		}
	}
}